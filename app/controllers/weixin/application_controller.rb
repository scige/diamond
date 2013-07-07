# coding:utf-8

class Weixin::ApplicationController < ActionController::Base
  skip_before_filter :verify_authenticity_token
  before_filter :check_weixin_legality
  before_filter :check_weixin_user_exist

  private
  def check_weixin_legality
    array = ["jilinmei_sanbaoyuan", params[:timestamp], params[:nonce]].sort
    render :text => "Forbidden", :status => 403 if params[:signature] != Digest::SHA1.hexdigest(array.join)
  end

  def check_weixin_user_exist
    weixin_user = WeixinUser.find_by_open_id(params[:xml][:FromUserName])
    if !weixin_user
      #创建失败需要记录一条错误日志
      WeixinUser.create(:status=>Setting.weixin_user.status_subscribe, :open_id=>params[:xml][:FromUserName])
    end
  end
end
