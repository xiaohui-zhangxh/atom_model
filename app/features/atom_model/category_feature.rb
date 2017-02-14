module AtomModel
  class CategoryFeature < Feature
    # == options
    #   category: Category#name
    def initialize(options)
      super
      category = Category.find_by(name: options[:category])
      fail "#{options[:category]} not found for #{self.class.name}" if category.nil?
    end
  end

  class CategoryFeatureValidator < ActiveModel::EachValidator
    attr_reader :category
    def validate_each(record, attribute, value)
      @category ||= Category.find_by(name: options[:parent_options][:category])
      klass = Feature.mount(features: category.features)
      inst = begin
        klass.new(value)
      rescue
        record.errors.add attribute, :invalid, options
        nil
      end
      return if inst.nil?
      unless inst.valid?
        record.errors.add attribute, inst.errors.as_json
      end
    end
  end
end
