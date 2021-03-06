class Cart < ApplicationRecord
  has_many :cart_products, dependent: :destroy
  has_many :products, through: :cart_products

  def sub_total
    sum = 0
    cart_products.each do |product|
      sum += product.total_price
    end
    sum
  end

  def total_items
    sum = 0
    cart_products.each do |product|
      sum += product.quantity
    end
    sum
  end
end
