class ShopsController < ApplicationController
  layout "application_mobile"

  def show
    @shop = Shop.find_by_id(params[:id])
    @guid = params[:spm]
    part = @shop.recommended_products.split
    @recommended_products = []
    cur = 0
    item = []
    part.each do |p|
      cur += 1
      item << p
      if cur == 4
        @recommended_products << item
        cur = 0
        item = []
      end
    end
    if item.size > 0
      (1..(4-item.size)).each do |i|
        item << ""
      end
      @recommended_products << item
    end
  end

  def map
    @shop = Shop.find_by_id(params[:id])
  end
end
