# == Schema Information
#
# Table name: assignments
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  ticket_id  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Assignment < ActiveRecord::Base
  attr_accessible :ticket_id, :user_id

  belongs_to :user
  belongs_to :ticket

  validates :ticket_id, presence: true
  validates :user_id, presence: true

end
