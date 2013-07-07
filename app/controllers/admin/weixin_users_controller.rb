class Admin::WeixinUsersController < ApplicationController
  before_filter :authenticate_super!

  def index
    @weixin_users = WeixinUser.all
  end

  def show
    @weixin_user = WeixinUser.find(params[:id])
  end

  def new
    @weixin_user = WeixinUser.new
  end

  def edit
    @weixin_user = WeixinUser.find(params[:id])
  end

  def create
    @weixin_user = WeixinUser.new(params[:weixin_user])

    if @weixin_user.save
      redirect_to admin_weixin_user_url(@weixin_user)
    else
      render action: "new"
    end
  end

  def update
    @weixin_user = WeixinUser.find(params[:id])

    if @weixin_user.update_attributes(params[:weixin_user])
      redirect_to admin_weixin_user_url(@weixin_user)
    else
      render action: "edit"
    end
  end

  def destroy
    @weixin_user = WeixinUser.find(params[:id])
    @weixin_user.destroy

    redirect_to admin_weixin_users_url
  end
end
