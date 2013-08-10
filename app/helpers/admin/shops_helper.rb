# coding: utf-8

module Admin::ShopsHelper
  def generate_shop_status
    [["未上架",Setting.shop.status_off_shelf], ["已上架",Setting.shop.status_on_shelf], ["待审核",Setting.shop.status_not_verify], ["审核失败",Setting.shop.status_verify_fail]]
  end
end
