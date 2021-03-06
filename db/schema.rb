# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130810031347) do

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.integer  "parent_id"
    t.integer  "lft"
    t.integer  "rgt"
    t.integer  "depth"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "coupons", :force => true do |t|
    t.integer  "status",         :default => 0
    t.string   "code"
    t.integer  "promo_id"
    t.integer  "weixin_user_id"
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
    t.integer  "shop_id"
  end

  add_index "coupons", ["code"], :name => "index_coupons_on_code"
  add_index "coupons", ["promo_id"], :name => "index_coupons_on_promo_id"
  add_index "coupons", ["shop_id"], :name => "index_coupons_on_shop_id"
  add_index "coupons", ["status"], :name => "index_coupons_on_status"
  add_index "coupons", ["weixin_user_id"], :name => "index_coupons_on_weixin_user_id"

  create_table "districts", :force => true do |t|
    t.string   "name"
    t.integer  "parent_id"
    t.integer  "lft"
    t.integer  "rgt"
    t.integer  "depth"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "editors", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "editors", ["email"], :name => "index_editors_on_email", :unique => true
  add_index "editors", ["reset_password_token"], :name => "index_editors_on_reset_password_token", :unique => true

  create_table "products", :force => true do |t|
    t.string   "name"
    t.float    "price"
    t.integer  "sales",      :default => 0
    t.integer  "star",       :default => 30
    t.integer  "shop_id"
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
  end

  add_index "products", ["name"], :name => "index_products_on_name"
  add_index "products", ["shop_id"], :name => "index_products_on_shop_id"

  create_table "promos", :force => true do |t|
    t.string   "name"
    t.text     "content"
    t.datetime "begin_at"
    t.datetime "end_at"
    t.string   "thumb"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
    t.integer  "status",     :default => 0
    t.string   "editor"
    t.string   "remarks"
  end

  add_index "promos", ["name"], :name => "index_promos_on_name"
  add_index "promos", ["status"], :name => "index_promos_on_status"

  create_table "shop_promo_relationships", :force => true do |t|
    t.integer  "shop_id"
    t.integer  "promo_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "shop_promo_relationships", ["promo_id"], :name => "index_shop_promo_relationships_on_promo_id"
  add_index "shop_promo_relationships", ["shop_id"], :name => "index_shop_promo_relationships_on_shop_id"

  create_table "shop_weixin_user_relationships", :force => true do |t|
    t.integer  "shop_id"
    t.integer  "weixin_user_id"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  add_index "shop_weixin_user_relationships", ["shop_id"], :name => "index_shop_weixin_user_relationships_on_shop_id"
  add_index "shop_weixin_user_relationships", ["weixin_user_id"], :name => "index_shop_weixin_user_relationships_on_weixin_user_id"

  create_table "shops", :force => true do |t|
    t.integer  "rank"
    t.integer  "shop_id"
    t.string   "name"
    t.string   "navigation"
    t.string   "poi"
    t.decimal  "latitude",             :precision => 15, :scale => 10
    t.decimal  "longitude",            :precision => 15, :scale => 10
    t.string   "thumb"
    t.integer  "star"
    t.integer  "avg_price"
    t.integer  "product_rating"
    t.integer  "environment_rating"
    t.integer  "service_rating"
    t.string   "recommended_products"
    t.string   "address"
    t.string   "phone"
    t.string   "description"
    t.string   "alias"
    t.string   "hours"
    t.string   "atmosphere"
    t.string   "characteristics"
    t.datetime "created_at",                                                          :null => false
    t.datetime "updated_at",                                                          :null => false
    t.integer  "status",                                               :default => 0
    t.string   "editor"
    t.string   "districts"
    t.string   "remarks"
  end

  add_index "shops", ["address"], :name => "index_shops_on_address"
  add_index "shops", ["districts"], :name => "index_shops_on_districts"
  add_index "shops", ["name"], :name => "index_shops_on_name"
  add_index "shops", ["navigation"], :name => "index_shops_on_navigation"
  add_index "shops", ["recommended_products"], :name => "index_shops_on_recommended_products"
  add_index "shops", ["status"], :name => "index_shops_on_status"

  create_table "supers", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "supers", ["email"], :name => "index_supers_on_email", :unique => true
  add_index "supers", ["reset_password_token"], :name => "index_supers_on_reset_password_token", :unique => true

  create_table "weixin_users", :force => true do |t|
    t.string   "open_id"
    t.string   "fake_id"
    t.string   "user_name"
    t.string   "nick_name"
    t.string   "remark_name"
    t.string   "country"
    t.string   "province"
    t.string   "city"
    t.integer  "sex"
    t.integer  "group_id"
    t.string   "signature"
    t.string   "mobile"
    t.string   "email"
    t.integer  "birthyear"
    t.string   "thumb"
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
    t.integer  "status",      :default => 0
    t.string   "guid"
    t.string   "gh_id"
    t.integer  "binding",     :default => 0
  end

  add_index "weixin_users", ["binding"], :name => "index_weixin_users_on_binding"
  add_index "weixin_users", ["gh_id"], :name => "index_weixin_users_on_gh_id"
  add_index "weixin_users", ["guid"], :name => "index_weixin_users_on_guid"
  add_index "weixin_users", ["open_id"], :name => "index_weixin_users_on_open_id"
  add_index "weixin_users", ["status"], :name => "index_weixin_users_on_status"

end
