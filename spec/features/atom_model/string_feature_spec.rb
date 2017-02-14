require 'rails_helper'

module AtomModel
  RSpec.describe StringFeature do
    it '.value' do
      expect(StringFeature.value(100)).to eq('100')
    end
  end
end
