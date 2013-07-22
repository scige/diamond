module ShopsHelper
  def get_phones(phones)
    phones.gsub(/0432-/, "").split(" ")
  end
end
