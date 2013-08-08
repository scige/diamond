module Weixin::PromosHelper
  def get_promo_shopid(promo, content)
    if promo.shops.size == 1
      return promo.shops[0].id
    end

    return nil
  end
end
