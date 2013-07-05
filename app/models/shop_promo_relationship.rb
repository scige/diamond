# == Schema Information
#
# Table name: shop_promo_relationships
#
#  id         :integer          not null, primary key
#  shop_id    :integer
#  promo_id   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class ShopPromoRelationship < ActiveRecord::Base
  belongs_to :shop
  belongs_to :promo

  attr_accessible :shop_id
  attr_accessible :promo_id

  validates :shop_id,  :presence => true,
                       :numericality => {:only_integer => true}
  validates :promo_id, :presence => true,
                       :numericality => {:only_integer => true}

  validates :shop_id,  :uniqueness => {:scope => :promo_id}
end
