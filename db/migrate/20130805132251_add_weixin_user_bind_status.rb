class AddWeixinUserBindStatus < ActiveRecord::Migration
  def change
    add_column :weixin_users, :binding, :integer, :default => Setting.weixin_user.binding_nick_name
    add_index  :weixin_users, :binding
  end
end
