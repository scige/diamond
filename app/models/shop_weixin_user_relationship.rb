# == Schema Information
#
# Table name: shop_weixin_user_relationships
#
#  id             :integer          not null, primary key
#  shop_id        :integer
#  weixin_user_id :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class ShopWeixinUserRelationship < ActiveRecord::Base
  belongs_to :shop
  belongs_to :weixin_user

  attr_accessible :shop_id
  attr_accessible :weixin_user_id

  validates :shop_id,  :presence => true,
                       :numericality => {:only_integer => true}
  validates :weixin_user_id, :presence => true,
                             :numericality => {:only_integer => true}

  validates :shop_id,  :uniqueness => {:scope => :weixin_user_id}
end
