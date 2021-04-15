class RemoveConstraintsInCartProducts < ActiveRecord::Migration[6.1]
  def change
    change_column :cart_products, :cart_id, :integer, null: true
    change_column :cart_products, :product_id, :integer, null: true
  end
end
