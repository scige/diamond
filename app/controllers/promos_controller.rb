class PromosController < ApplicationController
  layout "application_mobile"

  def show
    @promo = Promo.find_by_id(params[:id])
    @shop_id = params[:shop_id]
    @guid = params[:spm]
    @weixin_user = WeixinUser.find_by_guid(@guid)
  end
end
