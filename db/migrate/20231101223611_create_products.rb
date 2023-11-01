class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.string :product_name
      t.text :product_description
      t.decimal :product_price
      t.references :category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
