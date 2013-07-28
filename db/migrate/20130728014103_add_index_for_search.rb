class AddIndexForSearch < ActiveRecord::Migration
  def change
    add_index :shops, :status
    add_index :shops, :name
    add_index :shops, :address
    add_index :shops, :navigation
    add_index :shops, :districts
    add_index :shops, :recommended_products

    add_index :promos, :status
    add_index :promos, :name

    add_index :shop_promo_relationships, :shop_id
    add_index :shop_promo_relationships, :promo_id

    add_index :coupons, :status

    add_index :products, :name
    add_index :products, :shop_id

    add_index :weixin_users, :status
    add_index :weixin_users, :open_id
    add_index :weixin_users, :gh_id
  end
end
