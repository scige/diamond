class ShopsController < ApplicationController
  layout "application_mobile"

  def show
    @shop = Shop.find_by_id(params[:id])
    @guid = params[:spm]
    @weixin_user = WeixinUser.find_by_guid(@guid)
    redis_session = Redis::HashKey.new(@weixin_user.open_id + "_session")
    @keywords = redis_session[:keywords]
    parts = @shop.recommended_products.split
    if @keywords and !@keywords.empty?
      pos = parts.index{|x| x.index(@keywords)}
      if pos != nil
        match = parts[pos]
        parts.delete(match)
        parts.insert(0, match)
      end
    end
    @recommended_products = []
    cur = 0
    item = []
    parts.each do |p|
      cur += 1
      item << p
      if cur == 4
        @recommended_products << item
        cur = 0
        item = []
      end
    end
    if item.size > 0
      (1..(4-item.size)).each do |i|
        item << ""
      end
      @recommended_products << item
    end
    @recommended_products = @recommended_products[0..2]
  end

  def map
    @shop = Shop.find_by_id(params[:id])
  end
end
