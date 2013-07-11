class Weixin::ShopsController < Weixin::ApplicationController
  before_filter :sync_weixin_user_status

  def index
    @content = params[:xml][:Content]
    @shops = Shop.where("name like '%s'" % "%#{@content}%").limit(6)
    if @shops.size < 6
      @shops += Shop.where("navigation like '%s'" % "%#{@content}%").limit(6-@shops.size)
    end
    if @shops.size == 0
      render "weixin/shared/noresult"
    else
      render "index"
    end
  end
end
