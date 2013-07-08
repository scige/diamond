class AddCouponsShopId < ActiveRecord::Migration
  def change
    add_column :coupons, :shop_id, :integer
  end
end
