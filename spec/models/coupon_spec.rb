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

require 'spec_helper'

describe Coupon do
  pending "add some examples to (or delete) #{__FILE__}"
end
