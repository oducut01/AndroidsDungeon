class CheckoutController < ApplicationController
  def create
    product = Product.find(params[:product_id])

    redirect_to root_path if product.nil?

    @session = Stripe::Checkout::Session.create(
      payment_method_types: ["card"],
      success_url:          checkout_success_url + "?session_id={CHECKOUT_SESSION_ID}",
      cancel_url:           checkout_cancel_url,
      line_items:           [
        {
          name:        product.name,
          description: product.description,
          amount:      product.salePrice,
          currency:    "cad",
          quantity:    1
        },
        {
          name:        "GST",
          description: "Goods and Services Tax",
          amount:      (product.salePrice * 0.05).to_i,
          currency:    "cad",
          quantity:    1
        }
      ]
    )

    respond_to do |format|
      format.js
    end
  end

  def success
    @session = Stripe::Checkout::Session.retrieve(params[:session_id])
    @payment_intent = Stripe::PaymentIntent.retrieve(@session.payment_intent)
  end

  def cancel; end

end