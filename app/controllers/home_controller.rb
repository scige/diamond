class HomeController < ApplicationController
  def index
    @shops_editor1 = Shop.where("editor='846713848@qq.com'").order("created_at")
    @shops_editor2 = Shop.where("editor='469909985@qq.com'").order("created_at")

    @create_count_editor1 = {}
    @working_time_editor1 = {}
    @shops_editor1.each do |shop|
      hash_key = shop.created_at.to_s[0..9]
      if @create_count_editor1.has_key?(hash_key)
        @create_count_editor1[hash_key] += 1
        cur_time = shop.created_at.to_s[11..18]
        @working_time_editor1[hash_key][1] = cur_time
      else
        @create_count_editor1[hash_key] = 1
        cur_time = shop.created_at.to_s[11..18]
        @working_time_editor1[hash_key] = [cur_time, cur_time]
      end
    end

    @create_count_editor2 = {}
    @working_time_editor2 = {}
    @shops_editor2.each do |shop|
      hash_key = shop.created_at.to_s[0..9]
      if @create_count_editor2.has_key?(hash_key)
        @create_count_editor2[hash_key] += 1
        cur_time = shop.created_at.to_s[11..18]
        @working_time_editor2[hash_key][1] = cur_time
      else
        @create_count_editor2[hash_key] = 1
        cur_time = shop.created_at.to_s[11..18]
        @working_time_editor2[hash_key] = [cur_time, cur_time]
      end
    end

    @date_range = "2013-07-26".to_datetime..Time.now.to_datetime
  end
end
