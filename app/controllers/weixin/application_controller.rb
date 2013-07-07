# coding:utf-8

class Weixin::ApplicationController < ActionController::Base
  skip_before_filter :verify_authenticity_token
  before_filter :check_weixin_legality

  def sync_weixin_user_status
    weixin_user = WeixinUser.find_by_open_id(params[:xml][:FromUserName])
    if !weixin_user
      if !WeixinUser.create(:status=>Setting.weixin_user.status_subscribe, :open_id=>params[:xml][:FromUserName])
        #创建失败需要记录一条错误日志
      end
    else
      if weixin_user.status != Setting.weixin_user.status_subscribe
        if !weixin_user.update_attributes(:status=>Setting.weixin_user.status_subscribe)
          #更新失败需要记录一条错误日志
        end
      end
    end
  end

  private
  def check_weixin_legality
    array = ["jilinmei_sanbaoyuan", params[:timestamp], params[:nonce]].sort
    render :text => "Forbidden", :status => 403 if params[:signature] != Digest::SHA1.hexdigest(array.join)
  end
end
