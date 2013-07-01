class ShopsController < ApplicationController
  layout "application_mobile", :only => [:show]

  def show
    @shop = Shop.find_by_id(params[:id])
  end

  def map
    @shops = Shop.all
    #@shops = Shop.limit(10)
  end
end
