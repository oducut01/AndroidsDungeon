ActiveAdmin.register Product do
  permit_params :name, :salePrice, :msrp, :description, :quantity
end
