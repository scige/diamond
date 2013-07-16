# == Schema Information
#
# Table name: products
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  price      :float
#  sales      :integer          default(0)
#  star       :integer          default(30)
#  shop_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Product < ActiveRecord::Base
  belongs_to :shop

  attr_accessible :name
  attr_accessible :price
  attr_accessible :sales
  attr_accessible :star

  validates :name, :presence => true
end
