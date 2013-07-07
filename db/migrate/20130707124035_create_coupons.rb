class CreateCoupons < ActiveRecord::Migration
  def change
    create_table :coupons do |t|
      t.integer    :status, :default => Setting.coupon.status_unused
      t.string     :code
      t.references :promo
      t.references :weixin_user

      t.timestamps
    end

    add_index :coupons, :code
    add_index :coupons, :promo_id
    add_index :coupons, :weixin_user_id
  end
end
