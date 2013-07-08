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

ActiveRecord::Schema.define(:version => 20130708132006) do

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
  add_index "coupons", ["weixin_user_id"], :name => "index_coupons_on_weixin_user_id"

  create_table "promos", :force => true do |t|
    t.string   "name"
    t.text     "content"
    t.datetime "begin_at"
    t.datetime "end_at"
    t.string   "thumb"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
    t.integer  "status",     :default => 0
  end

  create_table "shop_promo_relationships", :force => true do |t|
    t.integer  "shop_id"
    t.integer  "promo_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "shops", :force => true do |t|
    t.integer  "rank"
    t.integer  "shop_id"
    t.string   "name"
    t.string   "navigation"
    t.string   "poi"
    t.float    "latitude"
    t.float    "longitude"
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
    t.datetime "created_at",                          :null => false
    t.datetime "updated_at",                          :null => false
    t.integer  "status",               :default => 0
  end

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
  end

  add_index "weixin_users", ["guid"], :name => "index_weixin_users_on_guid"

end
