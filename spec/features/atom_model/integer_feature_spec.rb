require 'rails_helper'

module AtomModel
  RSpec.describe IntegerFeature do
    it '.value' do
      expect(IntegerFeature.value('100.1')).to eq(100)
    end
  end
end
