class PromosController < ApplicationController
  layout "application_mobile"

  def show
    @promo = Promo.find_by_id(params[:id])
    @shop = Shop.find_by_id(params[:shop_id])
    @guid = params[:spm]
    @weixin_user = WeixinUser.find_by_guid(@guid)

    STAT_LOG.info "[promos/show]\t#{@weixin_user ? @weixin_user.open_id : ''}\t#{@promo.id}\t#{@promo.name}\t#{@shop ? @shop.id : ''}\t#{@shop ? @shop.name : ''}"
  end
end
