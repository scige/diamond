# coding:utf-8

class Weixin::ApplicationController < ActionController::Base
  skip_before_filter :verify_authenticity_token
  before_filter :check_weixin_legality

  def sync_weixin_user_status
    @weixin_user = WeixinUser.find_by_open_id(params[:xml][:FromUserName])
    if !@weixin_user
      @weixin_user = WeixinUser.create(:status=>Setting.weixin_user.status_subscribe, :open_id=>params[:xml][:FromUserName], :gh_id=>params[:xml][:ToUserName])
      if !@weixin_user
        #创建失败需要记录一条错误日志
        #create的返回值可能永远都不是nil
      end
    else
      if @weixin_user.status != Setting.weixin_user.status_subscribe
        if !@weixin_user.update_attributes(:status=>Setting.weixin_user.status_subscribe)
          #更新失败需要记录一条错误日志
        end
      end
    end
  end

  def merge_shops(shops0, shops1)
    intersection = shops0 & shops1
    #union = shops0 | shops1

    hit_two_shops = intersection
    #hit_one_shops = union - intersection

    hit_two_shops.sort! do |a, b|
      if b.star and a.star
        b.star <=> a.star
      elsif b.star
        1
      elsif a.star
        -1
      else
        0
      end
    end

    #hit_one_shops.sort! do |a, b|
    #  if b.star and a.star
    #    b.star <=> a.star
    #  elsif b.star
    #    1
    #  elsif a.star
    #    -1
    #  else
    #    0
    #  end
    #end

    return hit_two_shops
    #return hit_two_shops + hit_one_shops
  end

  private
  def check_weixin_legality
    array = ["jilinmei_sanbaoyuan", params[:timestamp], params[:nonce]].sort
    render :text => "Forbidden", :status => 403 if params[:signature] != Digest::SHA1.hexdigest(array.join)
  end
end
