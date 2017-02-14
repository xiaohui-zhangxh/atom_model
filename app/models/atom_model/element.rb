module AtomModel
  class Element < ApplicationRecord
    belongs_to :category

    def feature_values
      super || {}
    end
  end
end
