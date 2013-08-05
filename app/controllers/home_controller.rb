class HomeController < ApplicationController
  def index
    shops_editor1 = Shop.where("editor='846713848@qq.com'").order("created_at")
    shops_editor2 = Shop.where("editor='469909985@qq.com'").order("created_at")

    @count_editor1 = {}
    shops_editor1.each do |shop|
      hash_key = shop.created_at.to_s[0..9]
      if @count_editor1.has_key?(hash_key)
        @count_editor1[hash_key] += 1
      else
        @count_editor1[hash_key] = 1
      end
    end

    @count_editor2 = {}
    shops_editor2.each do |shop|
      hash_key = shop.created_at.to_s[0..9]
      if @count_editor2.has_key?(hash_key)
        @count_editor2[hash_key] += 1
      else
        @count_editor2[hash_key] = 1
      end
    end

    @date_range = "2013-07-20".to_datetime..Time.now.to_datetime
  end
end
