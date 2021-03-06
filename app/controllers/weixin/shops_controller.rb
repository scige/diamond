# coding: utf-8

class Weixin::ShopsController < Weixin::ApplicationController
  before_filter :sync_weixin_user_status

  MAX_SHOPS_NUM = 5

  def index
    @content = params[:xml][:Content].strip
    #参数非法性检查
    if !@content or @content.empty?
      render "weixin/shared/no_shops"
      return
    end

    words = @content.split(/ +|, *|， */)

    #如果是用户对话则直接退出
    words.each do |word|
      if word.size > 6
        return
      end
    end

    #不处理三个关键词的情况
    if words.size > 2
      words = words[0..1]
    end

    if words.size != 2
      query = words[0]
      @shops = Shop.where("name like '%#{query}%' or address like '%#{query}%' or navigation like '%#{query}%' or districts like '%#{query}%' or recommended_products like '%#{query}%'").order("star DESC")
    else
      query = words[0]
      shops0 = Shop.where("name like '%#{query}%' or address like '%#{query}%' or navigation like '%#{query}%' or districts like '%#{query}%' or recommended_products like '%#{query}%'").order("id")
      query = words[1]
      shops1 = Shop.where("name like '%#{query}%' or address like '%#{query}%' or navigation like '%#{query}%' or districts like '%#{query}%' or recommended_products like '%#{query}%'").order("id")
      @shops = merge_shops(shops0, shops1)
    end

    STAT_LOG.info "[weixins/search]\t#{params[:xml][:FromUserName]}\t#{params[:xml][:ToUserName]}\t#{@content}\t#{@shops.size}\t#{request.remote_ip}\t#{request.user_agent}"

    if @shops.size == 0
      render "weixin/shared/no_shops"
    else
      redis_session = Redis::HashKey.new(@weixin_user.open_id + "_session")
      redis_session[:keywords] = @content
      redis_session[:data_type] = "shops"
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
      @more_size = 0
      if more_shops
        @more_size = more_shops.size
      end
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
    shop_objs_hash = []
    @products.each do |product|
      if shops_hash.has_key?(product.shop_id)
        shops_hash[product.shop_id] += 1
      else
        if product.shop.status == Setting.shop.status_on_shelf
          shops_hash[product.shop_id] = 1
          shop_objs_hash[product.shop_id] = product.shop
        end
      end
    end

    shops_sorted = shops_hash.sort_by {|id, count| -count}

    @shops = []
    shops_sorted.each do |item|
      @shops << shop_objs_hash[item[0]]
    end

    STAT_LOG.info "[weixins/dingcan]\t#{params[:xml][:FromUserName]}\t#{params[:xml][:ToUserName]}\t#{@content}\t#{@shops.size}\t#{request.remote_ip}\t#{request.user_agent}"

    if @shops.size == 0
      render "weixin/shared/no_shops"
    else
      redis_session = Redis::HashKey.new(@weixin_user.open_id + "_session")
      redis_session[:keywords] = @content
      redis_session[:data_type] = "shops"
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
      @more_size = 0
      if @more_shops
        @more_size = more_shops.size
      end
      render "index"
    end
  end

  def more
    redis_session = Redis::HashKey.new(@weixin_user.open_id + "_session")
    @content = redis_session[:keywords]
    @data_type = redis_session[:data_type]
    redis_data = Redis::List.new(@weixin_user.open_id, :marshal=>true)

    STAT_LOG.info "[weixins/more]\t#{params[:xml][:FromUserName]}\t#{params[:xml][:ToUserName]}\t#{@content}\t#{@data_type}\t#{redis_data.size}\t#{request.remote_ip}\t#{request.user_agent}"

    if @data_type == "shops"
      if redis_data.nil? or redis_data.size == 0
        render "weixin/shared/no_more_shops"
      else
        @shops = redis_data[0..MAX_SHOPS_NUM-1]
        (1..MAX_SHOPS_NUM).each do |id|
          redis_data.shift
        end
        @more_size = 0
        if redis_data
          @more_size = redis_data.size
        end
        render "index"
      end
    else
      if redis_data.nil? or redis_data.size == 0
        render "weixin/shared/no_more_promos"
      else
        @promos = redis_data[0..MAX_SHOPS_NUM-1]
        (1..MAX_SHOPS_NUM).each do |id|
          redis_data.shift
        end
        @more_size = 0
        if redis_data
          @more_size = redis_data.size
        end
        render "weixin/promos/index"
      end
    end
  end

  def near
    render "weixin/shared/no_shops"
  end
end
