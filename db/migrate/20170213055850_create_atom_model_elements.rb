class CreateAtomModelElements < ActiveRecord::Migration[5.0]
  def change
    create_table :atom_model_elements do |t|
      t.references :category
      t.jsonb :feature_values

      t.timestamps
    end
  end
end
