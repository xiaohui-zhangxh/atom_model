module AtomModel
  class Category < ApplicationRecord
    store_accessor :options, :features
    has_many :elements, dependent: :destroy

    def features
      super || {}
    end

    def generate_class
      Feature.mount(features: features)
    end
  end
end
