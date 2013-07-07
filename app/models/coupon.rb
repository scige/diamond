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
#

class Coupon < ActiveRecord::Base
  belongs_to :promo
  belongs_to :weixin_user

  attr_accessible :status
  attr_accessible :code

  validates :status, :presence => true,
                     :numericality => {:only_integer => true}
  validates :code,   :presence => true,
                     :uniqueness => {:case_sensitive => false}

  validates :promo_id,       :presence => true,
                             :numericality => {:only_integer => true}
  validates :weixin_user_id, :presence => true,
                             :numericality => {:only_integer => true}
end
