class Log < ActiveRecord::Base
  attr_accessible :content, :ticket_id, :user_id

  belongs_to :ticket
  belongs_to :user

  default_scope order: 'logs.created_at DESC'

  validates :content, 		presence: true, length: { maximum: 200 }
  validates :user_id, 		presence: true
  validates :ticket_id, 	presence: true

end
