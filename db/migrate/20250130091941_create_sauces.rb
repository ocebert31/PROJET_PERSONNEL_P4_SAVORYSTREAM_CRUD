class CreateSauces < ActiveRecord::Migration[8.0]
  def change
    create_table :sauces do |t|
      t.string :nom, null: false
      t.text :description
      t.text :ingredients
      t.string :caracteristique
      t.integer :quantite, null: false
      t.decimal :prix, null: false

      t.timestamps
    end
  end
end
