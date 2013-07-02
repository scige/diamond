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

ActiveRecord::Schema.define(:version => 20130702002620) do

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
    t.datetime "created_at",           :null => false
    t.datetime "updated_at",           :null => false
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

end
