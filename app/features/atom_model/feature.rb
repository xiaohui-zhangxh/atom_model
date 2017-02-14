module AtomModel
  # == Example
  # k = Class.new{ include ActiveModel::Validations }
  # def k.name() 'dk' end
  # f = AtomModel::Feature.new(key: 'title', validates: { presence: true, length: 6..10 })
  # f.mount k
  # i= k.new
  # i.valid?
  # i.errors
  #
  # f2 = AtomModel::CollectionFeature.new(key: 'files', validates: { presence: true })
  # f2.mount k
  # i = k.new
  # i.valid?
  # i.errors
  class Feature
    attr_reader :key, :options

    # options keys:
    #   key: feature name
    #   validates: options of validates
    #   validator: options of validator(XxxFeatureValidator)
    def initialize(options)
      @options = options.deep_symbolize_keys
      @key = options[:key].intern
    end

    def mount_to(klass)
      mount_accessor klass, key
      mount_validates klass, key
      mount_validator klass, key
    end

    def self.mount(klass: nil, features:)
      klass ||= begin
        k = Class.new { include ActiveModel::Validations }
        def k.name() "FeaturedModel" end
        k.class_eval do
          def initialize(attributes = nil)
            attributes ||= {}
            attributes.each_pair do |k, v|
              send("#{k}=", v)
            end
          end
        end
        k
      end
      features.each_pair do |name, options|
        options = options.symbolize_keys
        feature = "::AtomModel::#{options[:type]}Feature".constantize.new(options.except(:type).merge(key: name))
        feature.mount_to klass
      end
      klass
    end

    private

    def mount_accessor(klass, key)
      mount_to_klass klass do
        attr_accessor key
      end
    end

    def mount_validates(klass, key)
      validates_options = options[:validates]
      return if validates_options.blank?
      mount_to_klass klass do
        validates key, validates_options
      end
    end

    def mount_validator(klass, key)
      validator_class = "#{self.class.name}Validator"
      validator =
        begin
          validator_class.include?('::') ? validator_class.constantize : self.class.const_get(validator_class)
        rescue NameError
          nil
        end
      return if validator.nil?
      validator_key = self.class.name.underscore
      validator_options = options[:validator] || {}
      validator_options[:parent_options] = options
      mount_to_klass klass do
        validates key, validator_key.intern => validator_options
      end
    end

    def mount_to_klass(klass, &block)
      klass.instance_eval(&block)
    end
  end
end
