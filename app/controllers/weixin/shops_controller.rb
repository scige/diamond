class Weixin::ShopsController < ApplicationController
  def index
    content = params[:xml][:Content][1..-1]
    @shops = Shop.where("name like '%s'" % "%#{content}%").limit(3)
    render "index"
  end
end
