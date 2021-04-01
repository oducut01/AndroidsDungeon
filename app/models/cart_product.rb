class CartProduct < ApplicationRecord
  belongs_to :Product
  belongs_to :Cart

  def total_price
    quantity * product.salePrice
  end
end
