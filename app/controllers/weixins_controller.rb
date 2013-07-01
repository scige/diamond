class WeixinsController < ApplicationController
  skip_before_filter :verify_authenticity_token
  before_filter :check_weixin_legality

  def index
    render :text => params[:echostr]
  end

  def create
    if params[:xml][:MsgType] == "text"
      content = params[:xml][:Content]
      @shops = Shop.where("name like '%s'" % "%#{content}%").limit(3)
      render "pic_text", :formats => :xml
    end
  end

  private
  def check_weixin_legality
    array = ["jilinmei_sanbaoyuan", params[:timestamp], params[:nonce]].sort
    render :text => "Forbidden", :status => 403 if params[:signature] != Digest::SHA1.hexdigest(array.join)
  end
end
