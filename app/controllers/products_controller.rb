class ProductsController < ApplicationController
  before_action :set_product, only: %i[show edit update destroy]

  # GET /products or /products.json
  def index
    @products = Product.all
  end

  # GET /products/1 or /products/1.json
  def show; end

  def search
    @products = Product.where("name LIKE ? OR description LIKE ?", "%#{params[:search_term]}%",
                              "%#{params[:search_term]}%")
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_product
    @product = Product.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def product_params
    params.require(:product).permit(:name, :salePrice, :msrp, :description, :quantity)
  end
end
