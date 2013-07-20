# coding: utf-8

class Weixin::ShopsController < Weixin::ApplicationController
  before_filter :sync_weixin_user_status

  MAX_SHOPS_NUM = 6

  def index
    @content = params[:xml][:Content]

    @shops = Shop.where("name like '%s'" % "%#{@content}%")
    @shops += Shop.where("navigation like '%s'" % "%#{@content}%")
    @shops += Shop.where("recommended_products like '%s'" % "%#{@content}%")

    if @shops.size == 0
      render "weixin/shared/noresult"
    else
      redis_session = Redis::HashKey.new(@weixin_user.open_id + "_session")
      redis_session[:keywords] = @content
      #清除存储的上次搜索结果
      redis_shops = Redis::List.new(@weixin_user.open_id, :marshal=>true)
      redis_shops.clear
      more_shops = @shops[MAX_SHOPS_NUM..-1]
      if more_shops and more_shops.size > 0
        more_shops.each do |shop|
          redis_shops << shop
        end
      end
      @shops = @shops[0..MAX_SHOPS_NUM-1]
      render "index"
    end
  end

  def dingcan
    @content = params[:xml][:Content][2..-1].strip
    #TODO: 这种实现[dc]的方式性能比较低, 以后需要改掉
    if @content and !@content.empty?
      @products = Product.where("name like '%s'" % "%#{@content}%")
    else
      @content = nil
      @products = Product.all
    end

    shops_hash = {}
    @shops = []
    @products.each do |product|
      if shops_hash.has_key?(product.shop_id)
        shops_hash[product.shop_id] += 1
      else
        shops_hash[product.shop_id] = 1
        @shops << product.shop
      end
    end

    if @shops.size == 0
      render "weixin/shared/noresult"
    else
      redis_session = Redis::HashKey.new(@weixin_user.open_id + "_session")
      redis_session[:keywords] = @content
      #清除存储的上次搜索结果
      redis_shops = Redis::List.new(@weixin_user.open_id, :marshal=>true)
      redis_shops.clear
      more_shops = @shops[MAX_SHOPS_NUM..-1]
      if more_shops and more_shops.size > 0
        more_shops.each do |shop|
          redis_shops << shop
        end
      end
      @shops = @shops[0..MAX_SHOPS_NUM-1]
      render "index"
    end
  end

  def more
    redis_session = Redis::HashKey.new(@weixin_user.open_id + "_session")
    @content = redis_session[:keywords]
    redis_shops = Redis::List.new(@weixin_user.open_id, :marshal=>true)
    if redis_shops.nil? or redis_shops.size == 0
      render "weixin/shared/no_more_result"
    else
      @shops = redis_shops[0..MAX_SHOPS_NUM-1]
      (1..MAX_SHOPS_NUM).each do |id|
        redis_shops.shift
      end
      render "index"
    end
  end
end
