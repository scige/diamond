class WeixinUsersController < ApplicationController
  layout "application_mobile"

  def myhome
    @guid = params[:spm]
    @weixin_user = WeixinUser.find_by_guid(@guid)

    STAT_LOG.info "[weixin_users/myhome]\t#{@weixin_user ? @weixin_user.open_id : ''}"
  end
end
