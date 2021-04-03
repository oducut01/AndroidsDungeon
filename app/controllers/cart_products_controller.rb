class CartProductsController < ApplicationController
  def create
    chosen_product = Product.find(params[:product_id])
    current_cart = @current_cart

    if current_cart.products.include?(chosen_product)
      @cart_product = current_cart.cart_products.find_by(product_id: chosen_product)
      @cart_product.quantity += 1
    else
      @cart_product = CartProduct.new
      @cart_product.cart = current_cart
      @cart_product.product = chosen_product
    end

    @cart_product.save
    flash[:notice] = "Added #{chosen_product.name} to the cart."
    redirect_to root_path
  end

  def destroy
    @cart_product = CartProduct.find(params[:product_id])
    @cart_product.destroy
    flash[:notice] = "Added #{chosen_product.name} to the cart."
    redirect_to root_path
  end

  def add_quantity
    @cart_product = LineItem.find(params[:product_id])
    @cart_product.quantity += 1
    @cart_product.save
    redirect_to cart_path(@current_cart)
  end

  private

  def cart_product_params
    params.require(:cart_product).permit(:quantity, :product_id, :cart_id)
  end
end
