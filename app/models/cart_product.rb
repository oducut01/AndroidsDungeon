class CartProduct < ApplicationRecord
  belongs_to :Product
  belongs_to :Cart
end
