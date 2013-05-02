class Assignment < ActiveRecord::Base
  attr_accessible :ticket_id, :user_id

  belongs_to :user
  belongs_to :ticket

  validates :ticket_id, presence: true
  validates :user_id, presence: true

end
