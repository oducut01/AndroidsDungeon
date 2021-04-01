class Product < ApplicationRecord
  validates :name, :salePrice, :msrp, :description, :quantity, presence: true
  validates :salePrice, :msrp, numericality: { only_integer: true }
  has_one_attached :image
  has_many :cart_products
  has_many :carts, through: :cart_products
  belongs_to :category
end
