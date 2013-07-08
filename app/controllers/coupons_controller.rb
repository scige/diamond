# coding: utf-8

class CouponsController < ApplicationController
  layout "application_mobile"

  def create
    shop = Shop.find(params[:shop_id])
    if !shop
      render :text => "商家不存在。"
      return
    end

    promo = Promo.find(params[:promo_id])
    if !promo
      render :text => "打折信息不存在。"
      return
    end

    weixin_user = WeixinUser.find_by_guid(params[:spm])
    if !weixin_user
      render :text => "微信用户不存在。"
      return
    end

    mobile = params[:mobile]
    if !check_mobile?(mobile)
      render :text => "您输入的手机号码 [#{mobile}] 有误，请重新输入。"
      return
    end

    @coupon = Coupon.new
    @coupon.shop = shop
    @coupon.promo = promo
    @coupon.weixin_user = weixin_user
    @coupon.status = Setting.coupon.status_unused
    # 重复尝试3次，超过3次返回错误信息
    (1..3).each do
      @coupon.code = generate_code
      if @coupon.save
        ret_code = send_to_mobile(mobile, shop.name, promo.name, @coupon.code)
        if ret_code == "0"
          if mobile != weixin_user.mobile
            if !weixin_user.update_attributes(:mobile=>mobile)
              #更新失败需要记录一条错误日志
            end
          end
          render :text => "优惠券已经发送到您的手机中！短信可能有延迟，请您耐心等待。"
          return
        end
      end
    end
    render :text => "优惠券在发送到您的手机时发生了错误！您可以尝试重新发送。"
  end

  private
  def generate_code
    part1 = rand(10000)
    part2 = rand(10000)
    part3 = rand(10000)
    code = "%04d%04d%04d" % [part1, part2, part3]
  end

  def check_mobile?(mobile)
    return (mobile and mobile.size == 11 and mobile =~/^1[358][0-9]/)
  end

  def send_to_mobile(mobile, shop_name, promo_name, code)
    head = "您的优惠券："
    body = "『#{shop_name}』#{promo_name}，"
    if code.size != 12
      return "-1"
    end
    detail = "密码#{code[0..3]} #{code[4..7]} #{code[8..11]}"
    tail = "【吉林美打折网】"
    content = head + body + detail + tail
    ret_code = "0"
    if Setting.send_coupon_to_mobile
      ret_code = RestClient.get "http://www.smsbao.com/sms", {:params => {:u=>"scige", :p=>"d1075f8c19041c4209a70601ca3543b4", :m=>mobile, :c=>content}}
    end
    # TODO: 诡异的现象：ret_code是"0"的情况下，to_i竟然是200
    logger.info "#{content} -- mobile: [#{mobile}] -- ret_code: [#{ret_code}]"
    return ret_code
  end
end
