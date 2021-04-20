class ProductsController < ApplicationController
  # GET /products or /products.json
  def index
    @products = if params[:filter_by]
                  load_products_by_filter
                elsif params[:category_id] != "" && params[:category_id]
                  load_products_by_category
                else
                  Product.page(params[:page]).order(:name)
                end
  end

  # GET /products/1 or /products/1.json
  def show
    @product = Product.find(params[:id])
  end

  def search
    @products = params[:category_id] == "" ? load_search_products : load_search_products_by_term
  end

  private

  def load_products_by_filter
    case params[:filter_by]
    when "sale"
      load_sale_products
    when "new"
      load_new_products
    when "updated"
      load_updated_products
    end
  end

  def load_sale_products
    Product.where("salePrice < msrp").page(params[:page]).order(:name)
  end

  def load_new_products
    Product.where(created_at: 3.days.ago..DateTime::Infinity.new)
           .page(params[:page]).order(:name)
  end

  def load_updated_products
    Product.where(updated_at: 3.days.ago..DateTime::Infinity.new)
           .where(created_at: Date.new..3.days.ago)
           .page(params[:page]).order(:name)
  end

  def load_products_by_category
    Product.where(category_id: params[:category_id]).page(params[:page]).order(:name)
  end

  def load_search_products
    Product.where("name LIKE ? OR description LIKE ?", "%#{params[:search_term]}%",
                  "%#{params[:search_term]}%")
           .page(params[:page]).order(:name)
  end

  def load_search_products_by_term
    Product.where("name LIKE ? OR description LIKE ?", "%#{params[:search_term]}%",
                  "%#{params[:search_term]}%")
           .where(category_id: params[:category_id])
           .page(params[:page]).order(:name)
  end
end
