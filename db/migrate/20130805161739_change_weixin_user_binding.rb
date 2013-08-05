class ChangeWeixinUserBinding < ActiveRecord::Migration
  def change
    change_column :weixin_users, :binding, :integer, :default => Setting.weixin_user.binding_none
  end
end
