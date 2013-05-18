# == Schema Information
#
# Table name: logs
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  ticket_id  :integer
#  event      :string(255)
#  content    :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Log < ActiveRecord::Base
  attr_accessible :content, :ticket_id, :user_id

  belongs_to :ticket
  belongs_to :user

  default_scope order: 'logs.created_at DESC'

  validates :content, 		presence: true, length: { maximum: 200 }
  validates :user_id, 		presence: true
  validates :ticket_id, 	presence: true

end
