# == Schema Information
#
# Table name: promos
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  content    :text
#  begin_at   :datetime
#  end_at     :datetime
#  thumb      :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Promo < ActiveRecord::Base
  has_many :shop_promo_relationships
  has_many :shops, :through => :shop_promo_relationships

  attr_accessible :name
  attr_accessible :content
  attr_accessible :begin_at
  attr_accessible :end_at
  attr_accessible :thumb

  validates_presence_of :name, :begin_at, :end_at
end
