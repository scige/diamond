# coding: utf-8
class Weixin::WeixinUsersController < Weixin::ApplicationController
  before_filter :sync_weixin_user_status, :only => [:subscribe, :myhome, :binding]

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

  def binding
    @content = params[:xml][:Content]
    case @weixin_user.binding
    when Setting.weixin_user.binding_nick_name
      if @weixin_user.update_attributes(:binding=>Setting.weixin_user.binding_user_name, :nick_name=>@content)
        @response_info = "设置成功！
请输入您的微信帐号，以便您附近的朋友可以通过微信号联系您。
（点击微信\"设置\"，再点击\"个人信息\"即可看到您的微信号。）"
      else
        @response_info = "设置失败！
请给自己取一个昵称，并回复给我们，如红糖哥。
（昵称不能超过一2个字和低于两个字，建议与微信昵称一致。"
      end
    when Setting.weixin_user.binding_user_name
      if @weixin_user.update_attributes(:binding=>Setting.weixin_user.binding_mobile, :user_name=>@content)
        @response_info = "设置成功！
请输入您的手机号，以便接收我们免费提供给您的商家优惠券。"
      else
        @response_info = "设置失败！
请输入您的微信帐号，以便您附近的朋友可以通过微信号联系您。
（点击微信\"设置\"，再点击\"个人信息\"即可看到您的微信号。）"
      end
    when Setting.weixin_user.binding_mobile
      if @weixin_user.update_attributes(:binding=>Setting.weixin_user.binding_finish, :mobile=>@content)
        @response_info = "设置成功！恭喜您，您已经成功绑定微信帐号！

昵称：#{@weixin_user.nick_name}
微信：#{@weixin_user.user_name}
手机：#{@weixin_user.mobile}

我们为您创建了个人主页
<a href=\"#{myhome_weixin_users_url(:spm=>@weixin_user.guid)}\">【请点我访问个人主页】</a>

如需了解如何使用本应用
<a href=\"http://wx.jilinmei.com/notices/help\">【请点我查看使用帮助】</a>"
      else
        @response_info = "设置失败！
请输入您的手机号，以便接收我们免费提供给您的商家优惠券。"
      end
    when Setting.weixin_user.binding_finish
    end
    render "binding"
  end
end
