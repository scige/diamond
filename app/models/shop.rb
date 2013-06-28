# == Schema Information
#
# Table name: shops
#
#  id                   :integer          not null, primary key
#  rank                 :integer
#  shop_id              :integer
#  name                 :string(255)
#  navigation           :string(255)
#  poi                  :string(255)
#  latitude             :float
#  longitude            :float
#  thumb                :string(255)
#  star                 :integer
#  avg_price            :integer
#  product_rating       :integer
#  environment_rating   :integer
#  service_rating       :integer
#  recommended_products :string(255)
#  address              :string(255)
#  phone                :string(255)
#  description          :string(255)
#  alias                :string(255)
#  hours                :string(255)
#  atmosphere           :string(255)
#  characteristics      :string(255)
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#

class Shop < ActiveRecord::Base
  attr_accessible :rank
  attr_accessible :shop_id
  attr_accessible :name
  attr_accessible :navigation
  attr_accessible :poi
  attr_accessible :latitude
  attr_accessible :longitude
  attr_accessible :thumb
  attr_accessible :star
  attr_accessible :avg_price
  attr_accessible :product_rating
  attr_accessible :environment_rating
  attr_accessible :service_rating
  attr_accessible :recommended_products
  attr_accessible :address
  attr_accessible :phone
  attr_accessible :description
  attr_accessible :alias
  attr_accessible :hours
  attr_accessible :atmosphere
  attr_accessible :characteristics
end
