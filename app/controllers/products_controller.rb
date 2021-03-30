class ProductsController < ApplicationController
  # GET /products or /products.json
  def index
    @products = if !params[:category_id] || params[:category_id] == ""
                  Product.all
                else
                  Product.where(category_id: params[:category_id])
                end
  end

  # GET /products/1 or /products/1.json
  def show
    @product = Product.find(params[:id])
  end

  def search
    @products = Product.where("name LIKE ? OR description LIKE ?", "%#{params[:search_term]}%",
                              "%#{params[:search_term]}%")
  end
end
