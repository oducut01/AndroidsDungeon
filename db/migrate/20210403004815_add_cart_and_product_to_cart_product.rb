class AddCartAndProductToCartProduct < ActiveRecord::Migration[6.1]
  def change
    add_reference :cart_products, :cart, null: false, foreign_key: true
    add_reference :cart_products, :product, null: false, foreign_key: true
  end
end
