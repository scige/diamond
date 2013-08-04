class Weixin::WeixinUsersController < Weixin::ApplicationController
  before_filter :sync_weixin_user_status, :only => [:subscribe]

  def subscribe
    STAT_LOG.info "[weixins/user]\t#{params[:xml][:FromUserName]}\t#{params[:xml][:ToUserName]}\t#{params[:xml][:Event]}"
    render "subscribe"
  end

  def unsubscribe
    @weixin_user = WeixinUser.find_by_open_id(params[:xml][:FromUserName])
    if !@weixin_user
      @weixin_user = WeixinUser.create(:status=>Setting.weixin_user.status_unsubscribe, :open_id=>params[:xml][:FromUserName], :gh_id=>params[:xml][:ToUserName])
      if !@weixin_user
        #创建失败需要记录一条错误日志
        #create的返回值可能永远都不是nil
      end
    else
      if !@weixin_user.update_attributes(:status=>Setting.weixin_user.status_unsubscribe)
        #更新失败需要记录一条错误日志
      end
    end

    STAT_LOG.info "[weixins/user]\t#{params[:xml][:FromUserName]}\t#{params[:xml][:ToUserName]}\t#{params[:xml][:Event]}"
    render :text => ""
  end

  def myhome
    STAT_LOG.info "[weixins/myhome]\t#{params[:xml][:FromUserName]}\t#{params[:xml][:ToUserName]}\t#{params[:xml][:Content]}"
    render "myhome"
  end
end
