class Log < ActiveRecord::Base
  attr_accessible :content, :event_id, :ticket_id, :user_id

  belongs_to :ticket
  belongs_to :user
  belongs_to :event

  validates :content, 		presence: true, length: { maximum: 200 }
  validates :user_id, 		presence: true
  validates :event_id, 		presence: true
  validates :ticket_id, 	presence: true

end
