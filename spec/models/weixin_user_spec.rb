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
#

require 'spec_helper'

describe WeixinUser do
  pending "add some examples to (or delete) #{__FILE__}"
end
