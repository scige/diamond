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
#

require 'spec_helper'

describe Promo do
  pending "add some examples to (or delete) #{__FILE__}"
end
