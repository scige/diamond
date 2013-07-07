class Weixin::HomeController < Weixin::ApplicationController
  def index
    render :text => params[:echostr]
  end
end
