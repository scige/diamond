# coding=utf-8

require 'json'
require 'yaml'
require 'nokogiri'
require 'open-uri'

filenames = []
data_path = "shop_data/"
Dir.foreach(data_path) do |filename|
  next if filename == "." or filename == ".."
  filenames << filename
end

filenames.sort!

thumb_file = File.open("jilin_shop_thumb.data", "w")

shop_data = []
filenames.each do |filename|
  puts "process: #{filename}"

  in_file = File.open(data_path + filename)
  page = in_file.read
  in_file.close
  
  item = {}
  doc = Nokogiri::HTML(page)

  #item["scraped_date"] = Time.now
  item["rank"] = filename.split("_")[2].to_i
  item["shop_id"] = filename.split(/[_.]/)[3].to_i

  item["name"] = doc.xpath('//*[@id="top"]/div[4]/div[1]/div[1]/div/div[1]/div[1]/h1').text.strip
  name = item["name"]

  navigation = doc.xpath('//*[@id="top"]/div[3]').text.strip
  next if navigation.index("吉林餐厅") == nil
  navi_begin = "吉林餐厅".size
  navi_end = navigation.size-item["name"].size
  item["navigation"] = navigation[navi_begin...navi_end].gsub(/»/, " ").strip

  #item["big_cate"] = 
  #item["small_cate1"] = 
  #item["small_cate2"] = 
  #item["area"] = 
  #item["landmark"] = 
  
  page =~ /(poi: ')([A-Z]{15})(')/
  item["poi"] = $2
  position = `python decode.py #{item["poi"]}`.strip.split
  #百度和图吧的坐标存在一定偏差
  item["latitude"] = (position[0].to_f + 0.0059).round(5)
  item["longitude"] = (position[1].to_f + 0.0015).round(5)

  thumb_url = doc.xpath('//*[@id="top"]/div[4]/div[1]/div[1]/div/div[3]/div[1]/div[1]/ul/li/a/img')[0]["src"].strip
  if thumb_url.index("no-photo") == nil
    item["thumb"] = "#{item["shop_id"]}.jpg"
  else
    item["thumb"] = ""
  end
  item["star"] = doc.xpath('//*[@id="top"]/div[4]/div[1]/div[1]/div/div[1]/div[2]/span')[0]["class"].strip[-2..-1].to_i
  item["avg_price"] = doc.xpath('//*[@id="top"]/div[4]/div[1]/div[1]/div/div[1]/div[2]/div/span[1]/strong').text.strip.gsub(/¥/, "").to_i
  item["product_rating"] = doc.xpath('//*[@id="top"]/div[4]/div[1]/div[1]/div/div[1]/div[2]/div/span[2]/strong').text.strip.to_i
  item["environment_rating"] = doc.xpath('//*[@id="top"]/div[4]/div[1]/div[1]/div/div[1]/div[2]/div/span[3]/strong').text.strip.to_i
  item["service_rating"] = doc.xpath('//*[@id="top"]/div[4]/div[1]/div[1]/div/div[1]/div[2]/div/span[4]/strong').text.strip.to_i

  item["address"] = doc.xpath('//*[@id="top"]/div[4]/div[1]/div[1]/div/div[3]/div[2]/div[1]/ul/li[1]/span').text.strip
  #item["phone"] = doc.xpath('//*[@id="top"]/div[4]/div[1]/div[1]/div/div[3]/div[2]/div[1]/ul/li[2]/span').text.strip
  phone = doc.xpath('//*[@id="top"]/div[4]/div[1]/div[1]/div/div[3]/div[2]/div[1]/ul/li[2]/span').text.strip.gsub(/0432-/, "")
  if phone.size == 8
    item["phone"] = "0432-" + phone
  elsif phone.size == 7
    item["phone"] = "0432-6" + phone
  elsif phone.size == 16
    item["phone"] = "0432-" + phone[0..7] + " " + phone[8..15]
  elsif phone.size == 14
    item["phone"] = "0432-6" + phone[0..6] + " 6" + phone[7..13]
  else
    item["phone"] = ""
  end

  #以下内容可能会不准确
  recommended_products = doc.xpath('//*[@id="dish-tag"]/div[2]/div[1]/div[1]/ul').text.strip.gsub(/[\r\n\t ]/, "").gsub(/\(\d*\)/, " ").strip
  if recommended_products.index("><") == nil
    item["recommended_products"] = recommended_products
  else
    item["recommended_products"] = ""
  end

  item["alias"] = ""
  item["description"] = ""
  item["hours"] = ""
  item["atmosphere"] = ""
  item["characteristics"] = ""

  other_info = []
  other_info << doc.xpath('//*[@id="top"]/div[4]/div[1]/div[1]/div/div[3]/div[2]/div[2]/div/ul/li[1]').text.strip.gsub(/[\r\n\t ]/, "")
  other_info << doc.xpath('//*[@id="top"]/div[4]/div[1]/div[1]/div/div[3]/div[2]/div[2]/div/ul/li[2]').text.strip.gsub(/[\r\n\t ]/, "")
  other_info << doc.xpath('//*[@id="top"]/div[4]/div[1]/div[1]/div/div[3]/div[2]/div[2]/div/ul/li[3]').text.strip.gsub(/[\r\n\t ]/, "")
  other_info << doc.xpath('//*[@id="top"]/div[4]/div[1]/div[1]/div/div[3]/div[2]/div[2]/div/ul/li[4]').text.strip.gsub(/[\r\n\t ]/, "")
  other_info << doc.xpath('//*[@id="top"]/div[4]/div[1]/div[1]/div/div[3]/div[2]/div[2]/div/ul/li[5]').text.strip.gsub(/[\r\n\t ]/, "")

  pattern_hash = [["餐厅别名：","alias"], ["餐厅简介：","description"], ["营业时间：","hours"], ["餐厅氛围：","atmosphere"], ["餐厅特色：","characteristics"]]

  other_info.each do |info|
    pattern_hash.each do |key, value|
      if info.index(key)
        if key == "营业时间："
          info.gsub!(/添加|修改/, "")
        end
        item[value] = info.gsub(/#{key}/, "").gsub(/\(\d*\)/, " ").strip
        break
      end
    end
  end

  shop_data << item

  if thumb_url.index("no-photo") == nil
    thumb_file.puts("#{thumb_url}\t#{item["photos"]}")
  end
  
  #item.each do |key, value|
  #  puts "#{key} = #{value}"
  #end

end

out_file = File.open("jilin_shop.yaml", "w")
out_file.puts(shop_data.to_yaml)
out_file.close

thumb_file.close

