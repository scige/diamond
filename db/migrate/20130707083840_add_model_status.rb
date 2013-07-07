class AddModelStatus < ActiveRecord::Migration
  def change
    add_column :shops, :status, :integer, :default => Setting.shop.status_off_shelf
    add_column :promos, :status, :integer, :default => Setting.promo.status_off_shelf
    add_column :weixin_users, :status, :integer, :default => Setting.weixin_user.status_unsubscribe
  end
end
