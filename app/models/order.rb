class Order < ApplicationRecord
  has_many :cart_products, dependent: :destroy
  belongs_to :customer

  def total
    sum = 0
    cart_products.each do |product|
      sum += product.total_price
    end
    taxes = (sum * (customer.province.gst + customer.province.pst + customer.province.hst) / 100_000)
    sum += taxes
  end
end
