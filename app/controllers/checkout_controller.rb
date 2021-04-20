class CheckoutController < ApplicationController
  def create
    line_items = cart.cart_products.collect { |item| item.to_builder.attributes! }
    email = nil
    if signed_in?
      add_additional_line_items(line_items)
      email = current_customer.email
    end
    create_session(line_items, email)
    respond_to do |format|
      format.js
    end
  end

  def success
    @session = Stripe::Checkout::Session.retrieve(params[:session_id])
    @payment_intent = Stripe::PaymentIntent.retrieve(@session.payment_intent)

    @order = Order.new
    set_order_columns
    @order.save
    Cart.destroy(session[:cart_id])
    session[:cart_id] = nil
    redirect_to orders_path
  end

  def cancel; end

  private

  def add_additional_line_items(line_items)
    set_line_item_taxes(line_items, "GST", "Goods & Services Tax", current_customer.province.gst)
    set_line_item_taxes(line_items, "PST", "Provincial Sales Tax", current_customer.province.pst)
    set_line_item_taxes(line_items, "HST", "Harmonized Sales Tax", current_customer.province.hst)
  end

  def set_line_item_taxes(line_items, name, description, type)
    return unless type != 0

    line_items << {
      name:        name,
      description: description,
      amount:      (cart.sub_total * (type / 100_000.0)).to_i,
      currency:    "cad",
      quantity:    1
    }
  end

  def create_session(line_items, email)
    @session = Stripe::Checkout::Session.create(
      mode:                        "payment",
      payment_method_types:        ["card"],
      success_url:                 "#{checkout_success_url}?session_id={CHECKOUT_SESSION_ID}",
      cancel_url:                  checkout_cancel_url,
      line_items:                  line_items,
      shipping_address_collection: {
        allowed_countries: ["CA"]
      }, customer_email:              email
    )
  end

  def set_order_columns
    @order.name = @session.shipping.name
    @order.email = @session.customer_email
    @order.status = @session.payment_status
    @order.customer_id = current_customer.id
    @order.payment_id = @session.payment_intent
    set_address
    set_taxes
    add_cart_products
  end

  def set_address
    @order.address = @session.shipping.address.line1
    @order.city = @session.shipping.address.city
    @order.province = @session.shipping.address.state
    @order.postalCode = @session.shipping.address.postal_code
  end

  def set_taxes
    province = Province.where(code: @order.province).first
    @order.gst_total = province.gst
    @order.pst_total = province.pst
    @order.hst_total = province.hst
  end

  def add_cart_products
    @current_cart.cart_products.each do |product|
      @order.cart_products << product
      product.cart_id = nil
    end
  end
end
