module AtomModel
  class Category < ApplicationRecord
    store_accessor :options, :features
    has_many :elements, dependent: :destroy

    def features
      super || {}
    end

    def parse_feature_values(json)
      fail ArgumentError, "argument must be a Hash" unless json.is_a?(Hash)
      output = {}
      features.each_pair do |feature_name, feature_options|
        output[feature_name] = Feature.of(feature_options['type']).new(feature_options.merge(key: feature_name)).value(json[feature_name])
      end
      output
    end

    def generate_class
      features = self.features.deep_symbolize_keys

      klass = Class.new do
        include ActiveModel::Validations
        features.each_pair do |feature_name, feature_options|
          feature = Feature.of(feature_options)
          attr_accessor feature_name
          validates feature_name, feature.validates_options if feature.validates_options.any?
        end
      end

      klass.instance_eval <<-CODE
        def name
          #{self.name.inspect}
        end
      CODE

      klass

      # block = Proc.new do
      #   features.deep_symbolize_keys.each_pair do |feature_name, feature_options|
      #     feature = Feature.of(feature_options)
      #     attr_accessor feature_name
      #     validates_presence_of feature_name if feature_options[:required]
      #     # validates_with feature::Validator
      #   end
      # end
    end
  end
end
