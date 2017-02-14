FactoryGirl.define do
  factory :atom_model_category, class: 'AtomModel::Category' do
    name "MyString"
    options({})

    factory :attachement_category do
      name '附件'
      features({
        "file_size" => { "type" => 'Integer', "required" => true },
        "file_type" => { "type" => 'String', "required" => true },
      })
    end

    factory :article_category do
      name '文章'
      features({
        "file_size" => { "type" => 'Integer', "required" => true },
        "file_type" => { "type" => 'String', "required" => true },
        "attachements" => { "type" => 'Collection', "feature" => 'Category', "feature_options" => { "category" => "附件", "share" => true } },
      })
    end
  end
end
