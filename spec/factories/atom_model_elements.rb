FactoryGirl.define do
  factory :atom_model_element, class: 'AtomModel::Element' do
    category nil
    feature_values ""

    factory :attachement_element do
      association :category, factory: :attachement_category
      feature_values('file_size' => '10240', 'file_type' => 'JPG')
    end
  end
end
