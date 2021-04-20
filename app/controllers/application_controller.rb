class ApplicationController < ActionController::Base
  before_action :current_cart
  before_action :update_allowed_parameters, if: :devise_controller?
  protect_from_forgery with: :exception
  helper_method :cart

  protected

  def update_allowed_parameters
    devise_parameter_sanitizer.permit(:sign_up) do |u|
      u.permit(:name, :phone, :address, :city, :province_id, :postalCode, :email, :password)
    end
    devise_parameter_sanitizer.permit(:account_update) do |u|
      u.permit(:name, :phone, :address, :city, :province_id, :postalCode, :email, :password,
               :current_password)
    end
  end

  private

  def current_cart
    if session[:cart_id]
      cart = Cart.find(session[:cart_id])
      cart.present? ? @current_cart = cart : session[:cart_id] = nil
    end
    return unless session[:cart_id].nil?

    @current_cart = Cart.create
    session[:cart_id] = @current_cart.id
  end

  def cart
    @cart = @current_cart
  end
end
