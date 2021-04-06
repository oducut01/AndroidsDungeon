class AddOrderToCartProducts < ActiveRecord::Migration[6.1]
  def change
    add_reference :cart_products, :order, foreign_key: true
  end
end
