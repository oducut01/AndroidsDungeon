class AddSalePriceToCartProducts < ActiveRecord::Migration[6.1]
  def change
    add_column :cart_products, :price, :integer
  end
end
