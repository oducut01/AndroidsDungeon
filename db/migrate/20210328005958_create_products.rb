class CreateProducts < ActiveRecord::Migration[6.1]
  def change
    create_table :products do |t|
      t.string :name
      t.integer :salePrice
      t.integer :msrp
      t.text :description
      t.integer :quantity

      t.timestamps
    end
  end
end
