# == Schema Information
#
# Table name: categories
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  parent_id  :integer
#  lft        :integer
#  rgt        :integer
#  depth      :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Category < ActiveRecord::Base
  acts_as_nested_set

  attr_accessible :name
end
