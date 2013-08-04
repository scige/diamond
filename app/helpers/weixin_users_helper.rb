module WeixinUsersHelper
  def has_promo?(weixin_user)
    if weixin_user.shops.size > 0
      has = false
      weixin_user.shops.each do |shop|
        if shop.promos.size > 0
          return true
        end
      end
    end
    return false
  end
end
