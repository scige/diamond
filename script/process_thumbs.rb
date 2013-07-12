# coding: utf-8

require 'yaml'

shop_data = YAML.load_file("jilin_shop.yaml")
number = 0
shop_data.each do |item|
    number += 1
    next if item["thumb"] == "no_photo.jpg"

    `mkdir uploads/shop/thumb/#{number}/`
    `cp uploads/shops/thumbs/thumb_#{item["shop_id"]}.jpg uploads/shop/thumb/#{number}/#{item["shop_id"]}.jpg`
    `cp uploads/shops/thumbs/thumb_#{item["shop_id"]}.jpg uploads/shop/thumb/#{number}/thumb_#{item["shop_id"]}.jpg`
    `cp uploads/shops/thumbs/thumb_#{item["shop_id"]}.jpg uploads/shop/thumb/#{number}/small_#{item["shop_id"]}.jpg`
    `cp uploads/shops/thumbs/thumb_#{item["shop_id"]}.jpg uploads/shop/thumb/#{number}/normal_#{item["shop_id"]}.jpg`
end
