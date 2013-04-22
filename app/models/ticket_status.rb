class TicketStatus < ActiveRecord::Base
  attr_accessible :status_descr

  validates :status_descr, presence: true, uniqueness: true
  
end
