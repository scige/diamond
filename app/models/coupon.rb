# == Schema Information
#
# Table name: coupons
#
#  id             :integer          not null, primary key
#  status         :integer          default(0)
#  code           :string(255)
#  promo_id       :integer
#  weixin_user_id :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  shop_id        :integer
#

class Coupon < ActiveRecord::Base
  belongs_to :shop
  belongs_to :promo
  belongs_to :weixin_user

  attr_accessible :status
  attr_accessible :code

  # maybe dangerous?
  attr_accessible :shop_id
  attr_accessible :promo_id
  attr_accessible :weixin_user_id

  validates :status, :presence => true,
                     :numericality => {:only_integer => true}
  validates :code,   :presence => true,
                     :uniqueness => {:case_sensitive => false}

  validates :shop_id,        :presence => true,
                             :numericality => {:only_integer => true}
  validates :promo_id,       :presence => true,
                             :numericality => {:only_integer => true}
  validates :weixin_user_id, :presence => true,
                             :numericality => {:only_integer => true}
end
