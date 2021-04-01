class CartController < ApplicationController
  def index; end

  def show; end

  def create
    logger.debug("Adding #{params[:product_id]} to the shopping cart.")
    id = params[:product_id].to_i
    session[:shopping_cart] << id
    product = Product.find(id)
    flash[:notice] = "Added #{product.name} to the cart."
    redirect_to root_path
  end

  def destroy
    logger.debug("Removing #{params[:id]} to the shopping cart.")
    id = params[:id].to_i
    session[:shopping_cart].delete(id)
    product = Product.find(id)
    flash[:notice] = "Removed #{product.name} to the cart."
    redirect_to root_path
  end
end
