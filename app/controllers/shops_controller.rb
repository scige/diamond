class ShopsController < ApplicationController
  layout "application_mobile"

  def show
    @shop = Shop.find_by_id(params[:id])
    @guid = params[:spm]
  end
end
