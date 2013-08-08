# coding: utf-8

class Weixin::PromosController < Weixin::ApplicationController
  before_filter :sync_weixin_user_status

  MAX_SHOPS_NUM = 5

  def index
    @content = params[:xml][:Content][2..-1].strip
    #TODO: 这种实现[dc]的方式性能比较低, 以后需要改掉
    if !@content or @content.empty?
      @content = nil
      @shops = Shop.all
    else
      words = @content.split(/ +|, *|， */)

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
    end

    @promos = []
    promos_hash = {}
    @shops.each do |shop|
      shop.promos.each do |promo|
        if promos_hash.has_key?(promo.id)
          promos_hash[promo.id] += 1
        else
          promos_hash[promo.id] = 1
          @promos << promo
        end
      end
    end

    STAT_LOG.info "[weixins/promo]\t#{params[:xml][:FromUserName]}\t#{params[:xml][:ToUserName]}\t#{@content}\t#{@shops.size}\t#{@promos.size}\t#{request.remote_ip}\t#{request.user_agent}"

    if @promos.size == 0
      render "weixin/shared/noresult"
    else
      redis_session = Redis::HashKey.new(@weixin_user.open_id + "_session")
      redis_session[:keywords] = @content
      #清除存储的上次搜索结果
      redis_promos = Redis::List.new(@weixin_user.open_id, :marshal=>true)
      redis_promos.clear
      more_promos = @promos[MAX_SHOPS_NUM..-1]
      if more_promos and more_promos.size > 0
        more_promos.each do |promo|
          redis_promos << promo
        end
      end
      @promos = @promos[0..MAX_SHOPS_NUM-1]
      @more_size = 0
      if more_promos
        @more_size = more_promos.size
      end
      render "index"
    end
  end

  def more
    redis_session = Redis::HashKey.new(@weixin_user.open_id + "_session")
    @content = redis_session[:keywords]
    redis_promos = Redis::List.new(@weixin_user.open_id, :marshal=>true)

    STAT_LOG.info "[weixins/more]\t#{params[:xml][:FromUserName]}\t#{params[:xml][:ToUserName]}\t#{@content}\t#{redis_promos.size}\t#{request.remote_ip}\t#{request.user_agent}"

    if redis_promos.nil? or redis_promos.size == 0
      render "weixin/shared/no_more_result"
    else
      @promos = redis_promos[0..MAX_SHOPS_NUM-1]
      (1..MAX_SHOPS_NUM).each do |id|
        redis_promos.shift
      end
      @more_size = 0
      if redis_promos
        @more_size = redis_promos.size
      end
      render "index"
    end
  end
end
