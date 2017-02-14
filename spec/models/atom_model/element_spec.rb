require 'rails_helper'

module AtomModel
  RSpec.describe Element, type: :model do

    let!(:attachement_category) { create(:attachement_category) }
    let!(:article_category) { create(:article_category) }
    let!(:attachements) { create_list(:attachement_element, 10, category: attachement_category) }

    it "create element" do
      my_attachements = attachements[0..2]
      ele = Element.new
      ele.category = article_category
      ele.feature_values = {
        'file_size' => 100,
        'title' => '我是标题',
        'attachements' => my_attachements.map(&:id)
      }
      expect(ele.save).to eq(true)
      ele.category.parse_feature_values(ele.feature_values)
      binding.pry
    end
  end
end
