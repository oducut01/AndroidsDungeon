class Order < ApplicationRecord
  has_many :cart_products, dependent: :destroy
  belongs_to :customer
end
