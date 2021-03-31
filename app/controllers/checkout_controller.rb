class CheckoutController < ApplicationController
  def create
    @product = Product.find(params[:product_id])

    respond_to do |format|
      format.js
    end
  end
end
