class Weixin::HomeController < ApplicationController
  def index
    render :text => params[:echostr]
  end
end
