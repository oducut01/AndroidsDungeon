class ProductsController < ApplicationController
  # GET /products or /products.json
  def index
    @products = if params[:filter_by] == "sale"
                  Product.where("salePrice < msrp").page(params[:page]).order(:name)
                elsif params[:filter_by] == "new"
                  Product.where(created_at: 3.days.ago..DateTime::Infinity.new).page(params[:page]).order(:name)
                elsif params[:filter_by] == "updated"
                  Product.where(updated_at: 3.days.ago..DateTime::Infinity.new)
                         .where(created_at: Date.new..3.days.ago)
                         .page(params[:page]).order(:name)
                elsif params[:category_id]
                  Product.where(category_id: params[:category_id]).page(params[:page]).order(:name)
                else
                  Product.page(params[:page]).order(:name)
                end
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
