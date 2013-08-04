class CreateShopWeixinUserRelationships < ActiveRecord::Migration
  def change
    create_table :shop_weixin_user_relationships do |t|
      t.integer :shop_id
      t.integer :weixin_user_id

      t.timestamps
    end

    add_index :shop_weixin_user_relationships, :shop_id
    add_index :shop_weixin_user_relationships, :weixin_user_id
  end
end
