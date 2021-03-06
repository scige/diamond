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
#  status     :integer          default(0)
#  editor     :string(255)
#  remarks    :string(255)
#

class Promo < ActiveRecord::Base
  has_many :coupons
  has_many :shop_promo_relationships
  has_many :shops, :through => :shop_promo_relationships

  attr_accessible :status
  attr_accessible :name
  attr_accessible :content
  attr_accessible :begin_at
  attr_accessible :end_at
  attr_accessible :thumb
  attr_accessible :editor
  attr_accessible :remarks

  validates :status,   :presence => true,
                       :numericality => {:only_integer => true}
  validates :name,     :presence => true,
                       :uniqueness => {:case_sensitive => false}
  validates :begin_at, :presence => true
  validates :end_at,   :presence => true

  mount_uploader :thumb, PromoThumbUploader
end
