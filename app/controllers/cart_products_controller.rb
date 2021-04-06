class CartProductsController < ApplicationController
  def create
    chosen_product = Product.find(params[:product_id])
    current_cart = @current_cart

    if current_cart.products.include?(chosen_product)
      @cart_product = current_cart.cart_products.find_by(product_id: chosen_product)
      @cart_product.quantity += params[:quantity].to_i
    else
      @cart_product = CartProduct.new
      @cart_product.cart = current_cart
      @cart_product.product = chosen_product
      @cart_product.quantity = params[:quantity].to_i
      @cart_product.order = nil
    end

    @cart_product.save

    flash[:notice] = "Added #{chosen_product.name} x #{params[:quantity].to_i} to the cart."
    redirect_to root_path
  end

  def destroy
    @cart_product = CartProduct.find(params[:product_id])
    flash[:notice] = "Removed #{@cart_product.product.name} from the cart."
    @cart_product.destroy
    redirect_to cart_path(@current_cart)
  end

  def change_quantity
    @cart_product = CartProduct.find(params[:id])
    @cart_product.quantity = params[:quantity]
    flash[:notice] = "Updated #{@cart_product.product.name} quantity."
    @cart_product.save
    redirect_to cart_path(@current_cart)
  end

  private

  def cart_product_params
    params.require(:cart_product).permit(:quantity, :product_id, :cart_id)
  end
end
