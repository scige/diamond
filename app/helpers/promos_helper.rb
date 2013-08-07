# coding: utf-8

module PromosHelper
  def get_format_date(time)
    time != nil ? "#{time.month}月#{time.day}日" : ""
  end
end
