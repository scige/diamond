class AddWeixinUserGuid < ActiveRecord::Migration
  def change
    add_column :weixin_users, :guid, :string
    add_index  :weixin_users, :guid
  end
end
