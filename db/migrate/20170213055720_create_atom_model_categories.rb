class CreateAtomModelCategories < ActiveRecord::Migration[5.0]
  def change
    create_table :atom_model_categories do |t|
      t.string :name
      t.jsonb :options

      t.timestamps
    end
  end
end
