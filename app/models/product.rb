class Product < ApplicationRecord
  validates :name, :salePrice, :msrp, :description, :quantity, presence: true
  validates :salePrice, :msrp, numericality: { only_integer: true }
  has_one_attached :image
  belongs_to :category
end
