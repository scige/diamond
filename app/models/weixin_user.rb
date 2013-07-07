# == Schema Information
#
# Table name: weixin_users
#
#  id          :integer          not null, primary key
#  open_id     :string(255)
#  fake_id     :string(255)
#  user_name   :string(255)
#  nick_name   :string(255)
#  remark_name :string(255)
#  country     :string(255)
#  province    :string(255)
#  city        :string(255)
#  sex         :integer
#  group_id    :integer
#  signature   :string(255)
#  mobile      :string(255)
#  email       :string(255)
#  birthyear   :integer
#  thumb       :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  status      :integer          default(0)
#

class WeixinUser < ActiveRecord::Base
  attr_accessible :status
  attr_accessible :open_id
  attr_accessible :fake_id
  attr_accessible :user_name
  attr_accessible :nick_name
  attr_accessible :remark_name

  attr_accessible :country
  attr_accessible :province
  attr_accessible :city
  attr_accessible :sex
  attr_accessible :group_id
  attr_accessible :signature

  attr_accessible :mobile
  attr_accessible :email
  attr_accessible :birthyear
  attr_accessible :thumb

  validates_presence_of :open_id
end
