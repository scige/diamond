class ShopsController < ApplicationController
  def show
    @shop = Shop.find_by_id(params[:id])
  end
end
