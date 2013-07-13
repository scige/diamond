class ApplicationController < ActionController::Base
  protect_from_forgery

  def deny_to_visitors
    redirect_to root_path unless super_signed_in? or editor_signed_in?
  end
end
