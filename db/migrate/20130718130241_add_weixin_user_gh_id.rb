class AddWeixinUserGhId < ActiveRecord::Migration
  def change
    add_column :weixin_users, :gh_id, :string
  end
end
