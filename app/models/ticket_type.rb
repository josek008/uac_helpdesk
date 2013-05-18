# == Schema Information
#
# Table name: ticket_types
#
#  id          :integer          not null, primary key
#  description :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class TicketType < ActiveRecord::Base
  attr_accessible :description
  
  validates :description, presence: true, uniqueness: true
end
