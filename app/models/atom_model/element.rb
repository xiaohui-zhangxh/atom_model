module AtomModel
  class Element < ApplicationRecord
    belongs_to :category
    validate :validate_feature_values

    def feature_values
      super || {}
    end

    private
    def validate_feature_values
      klass = category.generate_class
      inst = klass.new(feature_values)
      unless inst.valid?
        inst.errors.each_pair do |k, v|
          errors.add k, v
        end
      end
    end
  end
end
