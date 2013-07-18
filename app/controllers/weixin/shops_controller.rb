class Weixin::ShopsController < Weixin::ApplicationController
  before_filter :sync_weixin_user_status

  def index
    @content = params[:xml][:Content]
    @shops = Shop.where("name like '%s'" % "%#{@content}%").limit(6)
    if @shops.size < 6
      @shops += Shop.where("navigation like '%s'" % "%#{@content}%").limit(6-@shops.size)
    end
    if @shops.size < 6
      @shops += Shop.where("recommended_products like '%s'" % "%#{@content}%").limit(6-@shops.size)
    end

    if @shops.size == 0
      render "weixin/shared/noresult"
    else
      render "index"
    end
  end

  def dingcan
    @content = params[:xml][:Content][2..-1].strip
    @products = Product.where("name like '%s'" % "%#{@content}%")
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
    @shops = @shops[0..5]

    if @shops.size == 0
      render "weixin/shared/noresult"
    else
      render "index"
    end
  end
end
