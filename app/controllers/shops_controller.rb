class ShopsController < ApplicationController
  layout "application_mobile"

  def show
    @keywords = params[:keywords]
    @shop = Shop.find_by_id(params[:id])
    @guid = params[:spm]
    @weixin_user = WeixinUser.find_by_guid(@guid)

    #redis_session = Redis::HashKey.new(@weixin_user.open_id + "_session")
    #@keywords = redis_session[:keywords]

    STAT_LOG.info "[shops/show]\t#{@weixin_user ? @weixin_user.open_id : ''}\t#{@keywords}\t#{@shop.id}\t#{@shop.name}"

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
    @shop = Shop.find_by_id(params[:shop_id])
    @keywords = params[:keywords]
    @guid = params[:spm]
    @weixin_user = WeixinUser.find_by_guid(@guid)

    STAT_LOG.info "[shops/map]\t#{@weixin_user ? @weixin_user.open_id : ''}\t#{@keywords}\t#{@shop.id}\t#{@shop.name}"
  end

  def phone
    phone = params[:phone]
    keywords = params[:keywords]
    shop = Shop.find_by_id(params[:shop_id])
    guid = params[:spm]
    weixin_user = WeixinUser.find_by_guid(guid)

    STAT_LOG.info "[shops/phone]\t#{weixin_user ? weixin_user.open_id : ''}\t#{keywords}\t#{shop.id}\t#{shop.name}\t#{phone}"

    redirect_to "tel:#{phone}"
  end

  def follow
    @shop = Shop.find_by_id(params[:shop_id])
    @guid = params[:spm]
    @weixin_user = WeixinUser.find_by_guid(@guid)

    ShopWeixinUserRelationship.create!(:shop_id=>@shop.id, :weixin_user_id=>@weixin_user.id)

    STAT_LOG.info "[shops/follow]\t#{@weixin_user ? @weixin_user.open_id : ''}\t#{@shop.id}\t#{@shop.name}\t#{@weixin_user ? @weixin_user.shops.size : ''}"

    respond_to do |format|
      format.js {render :layout => false}
    end
  end

  def unfollow
    @shop = Shop.find_by_id(params[:shop_id])
    @guid = params[:spm]
    @weixin_user = WeixinUser.find_by_guid(@guid)

    relations = ShopWeixinUserRelationship.where(:shop_id=>@shop.id, :weixin_user_id=>@weixin_user.id)
    relations.each do |relation|
      relation.destroy
    end

    STAT_LOG.info "[shops/unfollow]\t#{@weixin_user ? @weixin_user.open_id : ''}\t#{@shop.id}\t#{@shop.name}\t#{@weixin_user ? @weixin_user.shops.size : ''}"

    respond_to do |format|
      format.js {render :layout => false}
    end
  end
end
