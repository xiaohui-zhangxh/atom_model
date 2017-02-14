module AtomModel
  <<-DOC

features = {
  files: { type: 'Collection', feature: { type: 'Integer', validates: {presence: true,} }, validates: { presence: true } },
  cats: { type: 'Collection', validates: {presence: true}, feature: { type: 'Category', category: '附件', validates: { presence: true } }, validator: { message: '文件错误' } },
}

klass = AtomModel::Feature.mount(features: features)
i = klass.new
i.valid?
i.errors
i.cats = ["a"]
i.valid?
i.errors

  DOC
  class CollectionFeature < Feature
    def initialize(*)
      super
      fail ArgumentError, "feature is required for #{self.class.name}" if options[:feature].blank?
      fail ArgumentError, "feature[:type] is required for #{self.class.name}" if options[:feature][:type].blank?
    end
  end
  class CollectionFeatureValidator < ActiveModel::EachValidator
    def validate_each(record, attribute, value)
      return if value.blank?
      unless value.is_a?(Array)
        record.errors.add attribute, :invalid_collection, options
      else
        feature_options = options[:parent_options][:feature]
        klass = Feature.mount(features: { value: feature_options })
        value.each_with_index do |v,idx|
          inst = klass.new
          inst.value = v
          unless inst.valid?
            inst.errors[:value].each do |e|
              record.errors.add "#{attribute}[#{idx}]", e
            end
          end
        end
      end
    end
  end
end
