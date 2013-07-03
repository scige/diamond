class Promo < ActiveRecord::Base
  attr_accessible :name
  attr_accessible :content
  attr_accessible :begin_at
  attr_accessible :end_at
  attr_accessible :thumb
end
