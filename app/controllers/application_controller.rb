class ApplicationController < ActionController::Base
  before_action :current_cart
  protect_from_forgery with: :exception
  helper_method :cart

  private

  def current_cart
    if session[:cart_id]
      cart = Cart.find(session[:cart_id])
      if cart.present?
        @current_cart = cart
      else
        session[:cart_id] = nil
      end
    end

    if session[:cart_id].nil?
      @current_cart = Cart.create
      session[:cart_id] = @current_cart.id
    end
  end

  def cart
    @cart = @current_cart
  end
end
