# coding: utf-8

class CouponsController < ApplicationController
  layout "application_mobile"

  def create
    render :text => "优惠券已经发送到您的手机"
  end
end
