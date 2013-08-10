# coding: utf-8

module Admin::PromosHelper
  def generate_promo_status
    [["未上架",Setting.promo.status_off_shelf], ["已上架",Setting.promo.status_on_shelf], ["待审核",Setting.promo.status_not_verify], ["审核失败",Setting.shop.status_verify_fail]]
  end
end
