class ProductsController < ApplicationController
  # GET /products or /products.json
  def index
    @products = if !params[:category_id] || params[:category_id] == ""
                  Product.page(params[:page])
                         .order(:name)
                else
                  Product.where(category_id: params[:category_id])
                         .page(params[:page])
                         .order(:name)
                end

    @visit_count = visit_count
  end

  # GET /products/1 or /products/1.json
  def show
    @product = Product.find(params[:id])
  end

  def search
    @products = if params[:category_id] == ""
                  Product.where("name LIKE ? OR description LIKE ?", "%#{params[:search_term]}%",
                                "%#{params[:search_term]}%")
                         .page(params[:page])
                         .order(:name)
                else
                  Product.where("name LIKE ? OR description LIKE ?", "%#{params[:search_term]}%",
                                "%#{params[:search_term]}%")
                         .where(category_id: params[:category_id])
                         .page(params[:page])
                         .order(:name)
                end
  end
end
