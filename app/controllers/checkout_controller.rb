class CheckoutController < ApplicationController
  def create
    # product = Product.find(params[:product_id])

    # redirect_to root_path if product.nil?

    line_items = cart.cart_products.collect { |item| item.to_builder.attributes! }

    if signed_in?
      if current_customer.province.gst != 0
        line_items << {
          name:        "GST",
          description: "Goods & Services Tax",
          amount:      (cart.sub_total * (current_customer.province.gst / 100_000.0)).to_i,
          currency:    "cad",
          quantity:    1
        }
      end

      if current_customer.province.pst != 0
        line_items << {
          name:        "PST",
          description: "Provincial Sales Tax",
          amount:      (cart.sub_total * (current_customer.province.pst / 100_000.0)).to_i,
          currency:    "cad",
          quantity:    1
        }
      end

      if current_customer.province.hst != 0
        line_items << {
          name:        "HST",
          description: "Harmonized Sales Tax",
          amount:      (cart.sub_total * (current_customer.province.hst / 100_000.0)).to_i,
          currency:    "cad",
          quantity:    1
        }
      end

      email = current_customer.email
    else
      email = nil
    end

    # customer = Stripe::Customer.create(
    #   description: "My First Test Customer (created for API docs)",
    #   address:     {
    #     city:        "Winnipeg",
    #     country:     "CA",
    #     line1:       "123 Fake St.",
    #     postal_code: "h0h 0h0",
    #     state:       "MB"
    #   },
    #   shipping:    {
    #     address: {
    #       city:        "Winnipeg",
    #       country:     "CA",
    #       line1:       "123 Fake St.",
    #       postal_code: "h0h 0h0",
    #       state:       "MB"
    #     },
    #     name:    "Joe",
    #     phone:   "1231234"
    #   }
    # )

    @session = Stripe::Checkout::Session.create(
      mode:                        "payment",
      payment_method_types:        ["card"],
      success_url:                 checkout_success_url + "?session_id={CHECKOUT_SESSION_ID}",
      cancel_url:                  checkout_cancel_url,
      line_items:                  line_items,
      shipping_address_collection: {
        allowed_countries: ["CA"]
      },
      customer_email:              email
    )

    respond_to do |format|
      format.js
    end
  end

  def success
    @session = Stripe::Checkout::Session.retrieve(params[:session_id])
    @payment_intent = Stripe::PaymentIntent.retrieve(@session.payment_intent)

    @order = Order.new
    @order.name = @session.shipping.name
    @order.email = @session.customer_email
    @order.address = @session.shipping.address.line1
    @order.city = @session.shipping.address.city
    @order.postalCode = @session.shipping.address.postal_code
    @order.status = @session.payment_status
    @order.gst_total = 0
    @order.pst_total = 0
    @order.hst_total = 0
    @order.customer_id = current_customer.id

    @current_cart.cart_products.each do |product|
      @order.cart_products << product
      product.cart_id = nil
    end
    @order.save
    Cart.destroy(session[:cart_id])
    session[:cart_id] = nil
    redirect_to orders_path
  end

  def cancel; end
end
