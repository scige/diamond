class Weixin::ApplicationController < ActionController::Base
  skip_before_filter :verify_authenticity_token
  before_filter :check_weixin_legality

  private
  def check_weixin_legality
    array = ["jilinmei_sanbaoyuan", params[:timestamp], params[:nonce]].sort
    render :text => "Forbidden", :status => 403 if params[:signature] != Digest::SHA1.hexdigest(array.join)
  end
end
