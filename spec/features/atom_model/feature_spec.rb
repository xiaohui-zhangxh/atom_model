require 'rails_helper'

module AtomModel
  RSpec.describe Feature do
    subject { Class.new.send(:include, Feature) }
    it 'self responds to "of"' do
      expect(Feature.respond_to?(:of)).to eq(true)
    end

    it 'self responds to "value"' do
      expect(subject.respond_to?(:value)).to eq(true)
    end

    it 'ensure value fail' do
      expect{subject.value(1)}.to raise_error(RuntimeError)
    end
  end
end
