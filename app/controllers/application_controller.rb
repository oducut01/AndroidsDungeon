class ApplicationController < ActionController::Base
  # before_action :initialize_session, :increment_visit_count
  # helper_method :visit_count

  private

  def initialize_session
    session[:shopping_cart] ||= []
  end

  def cart
    Product.find(session[:shopping_cart])
  end
end
