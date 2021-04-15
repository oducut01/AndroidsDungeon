class Product < ApplicationRecord
  validates :name, :salePrice, :msrp, :description, :quantity, presence: true
  validates :msrp, numericality: { only_integer: true }
  validates :salePrice, numericality: { only_integer: true, less_than_or_equal_to: :msrp }
  has_one_attached :image
  has_many :cart_products, dependent: :destroy
  belongs_to :category
end
