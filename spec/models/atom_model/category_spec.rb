require 'rails_helper'

module AtomModel
  RSpec.describe Category, type: :model do
    pending "add some examples to (or delete) #{__FILE__}"

    it 'create category' do
      c = AtomModel::Category.new(name: '附件')
      c.features = {
        'file_size': { label: '文件大小', type: 'Integer', required: true },
        'file_type': { label: '文件类型', type: 'String', required: true }
      }
      expect(c.save).to eq(true)
    end
  end
end
