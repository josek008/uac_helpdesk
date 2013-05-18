# == Schema Information
#
# Table name: scores
#
#  id          :integer          not null, primary key
#  description :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Score < ActiveRecord::Base
  attr_accessible :description

  has_one :survey

end
