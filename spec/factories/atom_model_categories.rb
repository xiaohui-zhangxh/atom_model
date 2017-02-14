FactoryGirl.define do
  factory :atom_model_category, class: 'AtomModel::Category' do
    name "MyString"
    options({})

    factory :attachement_category do
      name '附件'
      features({
        "file_size" => { "type" => 'Integer', validates: { presence: true } },
        "file_type" => { "type" => 'String', validates: { presence: true } },
      })
    end

    factory :article_category do
      name '文章'
      features({
        "title" => { type: 'String', validates: { presence: true, length: { maximum: 80 } } },
        "body" => { type: 'String', validates: { presence: true } },
        "attachements" => { type: 'Collection', feature: { type: 'Category', category: '附件' } },
      })
    end
  end
end
