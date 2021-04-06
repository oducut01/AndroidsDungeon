class CheckoutController < ApplicationController
  def create
    # product = Product.find(params[:product_id])

    # redirect_to root_path if product.nil?

    line_items = cart.cart_products.collect { |item| item.to_builder.attributes! }

    line_items << {
      name:        "GST",
      description: "Goods and Services Tax",
      amount:      (cart.sub_total * 0.05).to_i,
      currency:    "cad",
      quantity:    1
    }

    line_items << {
      name:        "PST",
      description: "Provincial Sales Tax",
      amount:      (cart.sub_total * 0.07).to_i,
      currency:    "cad",
      quantity:    1
    }

    @session = Stripe::Checkout::Session.create(
      payment_method_types:        ["card"],
      success_url:                 checkout_success_url + "?session_id={CHECKOUT_SESSION_ID}",
      cancel_url:                  checkout_cancel_url,
      line_items:                  line_items,
      shipping_address_collection: {
        allowed_countries: ["CA"]
      }
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
