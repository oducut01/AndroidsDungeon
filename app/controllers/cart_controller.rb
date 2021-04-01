class CartController < ApplicationController
  def create
    logger.debug("Adding #{[params[:id]]} to the shopping cart.")
  end

  def destroy
    logger.debug("Removing #{[params[:id]]} to the shopping cart.")
  end
end
