# coding: utf-8

class PromosController < ApplicationController
  layout "application_mobile"

  def show
    @promo = Promo.find_by_id(params[:id])
    @shop = Shop.find_by_id(params[:shop_id])
    @guid = params[:spm]
    @weixin_user = WeixinUser.find_by_guid(@guid)

    @shop_detail_address = ""
    if @shop
      parts = @shop.districts.strip.split
      district = ""
      if parts
        parts.each do |part|
          if part[-1] == "区"
            district = part
            break
          end
        end
      end
      @shop_detail_address = district + @shop.address
    else
      #!!!直接搜索优惠券来访问的，并且拥有这个优惠券的商家多于1个，生成coupon时会有问题
      @promo.shops.each do |shop|
        @shop_detail_address += shop.address + "; "
      end
    end

    STAT_LOG.info "[promos/show]\t#{@weixin_user ? @weixin_user.open_id : ''}\t#{@promo.id}\t#{@promo.name}\t#{@shop ? @shop.id : ''}\t#{@shop ? @shop.name : ''}"
  end
end
