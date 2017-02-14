require 'rails_helper'

module AtomModel
  RSpec.describe CategoryFeature do
    let!(:attachement) {
      c = Category.new(name: '附件')
      c.features = {
        file_size: { label: '文件大小', type: 'Integer', required: true },
        file_type: { label: '文件类型', type: 'String', required: true }
      }
      c.save
      c
    }
    it '.value' do
      v = CategoryFeature.value({'file_size' => '100', 'file_type' => 'Doc'}, 'category' => attachement.name)
      expect(v['file_size']).to eq(100)
    end
  end
end
