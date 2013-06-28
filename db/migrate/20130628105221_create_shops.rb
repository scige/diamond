class CreateShops < ActiveRecord::Migration
  def change
    create_table :shops do |t|
      t.integer  :rank
      t.integer  :shop_id
      t.string   :name
      t.string   :navigation
      t.string   :poi
      t.float    :latitude
      t.float    :longitude
      t.string   :thumb
      t.integer  :star
      t.integer  :avg_price
      t.integer  :product_rating
      t.integer  :environment_rating
      t.integer  :service_rating
      t.string   :recommended_products
      t.string   :address
      t.string   :phone
      t.string   :description
      t.string   :alias
      t.string   :hours
      t.string   :atmosphere
      t.string   :characteristics

      t.timestamps
    end
  end
end
