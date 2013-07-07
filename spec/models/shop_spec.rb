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
#  status               :integer          default(0)
#

require 'spec_helper'

describe Shop do
  pending "add some examples to (or delete) #{__FILE__}"
end
