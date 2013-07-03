module PromosHelper
  def get_format_date(time)
    time != nil ? time.strftime('%Y-%m-%d') : ""
  end
end
