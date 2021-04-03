class CartProduct < ApplicationRecord
  belongs_to :product
  belongs_to :cart

  def to_builder
    Jbuilder.new do |product|
      product.name self.product.name
      product.currency "CAD"
      product.amount self.product.salePrice
      product.quantity quantity
      # product.tax_rates [gst, pst]
    end
  end

  def total_price
    quantity * product.salePrice
  end
end
