class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.string :title
      t.integer :quantity
      t.integer :price
      t.string :description
      t.references :seller, foreign_key: true

      t.timestamps
    end
  end
end
