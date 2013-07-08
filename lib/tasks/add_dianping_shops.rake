# coding: utf-8

require 'yaml'

namespace :db do
  desc "add dianping shops to mysql"
  task :add_dianping_shops => :environment do
    index_begin = ENV['index_begin'].to_i
    index_end = ENV['index_end'].to_i
    shop_data = YAML.load_file("lib/tasks/jilin_shop.yaml")
    shop_data[index_begin..index_end].each do |item|
      begin
        Shop.create!(item)
      rescue
        puts item
      end
    end
  end
end
