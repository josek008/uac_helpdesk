class Ticket < ActiveRecord::Base
	attr_accessible :description, :category_id, :ticket_type_id

	belongs_to :user
	belongs_to :category
	belongs_to :survey_score
	belongs_to :ticket_status
	belongs_to :ticket_type
	
	validates :description, 	presence: true, length: { maximum: 650 }
	validates :user_id, 		presence: true
	validates :category_id, 		presence: true
	validates :ticket_status_id, 	presence: true
	validates :ticket_type_id,	 	presence: true
	
end
