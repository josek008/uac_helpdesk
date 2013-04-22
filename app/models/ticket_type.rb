class TicketType < ActiveRecord::Base
  attr_accessible :type_descr
  
  validates :type_descr, presence: true, uniqueness: true
end
