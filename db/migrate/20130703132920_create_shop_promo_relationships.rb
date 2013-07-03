class CreateShopPromoRelationships < ActiveRecord::Migration
  def change
    create_table :shop_promo_relationships do |t|
      t.integer :shop_id
      t.integer :promo_id

      t.timestamps
    end
  end
end
