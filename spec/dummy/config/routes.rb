Rails.application.routes.draw do
  mount AtomModel::Engine => "/atom_model"
end
