class Ticket < ActiveRecord::Base
	attr_accessible :category, :closed_date, :created_by, :description, :resolution_date, 
	:survey_score, :ticket_status, :ticket_type

	belongs_to :user, class_name: "User", foreign_key: "created_by_id"
	belongs_to :category
	belongs_to :survey_score
	belongs_to :ticket_status
	belongs_to :ticket_type
	
	validates :content, 	presence: true, length: { maximum: 650 }
	validates :created_by, 	presence: true
	validates :category, 	presence: true
	validates :ticket_status, 	presence: true
	validates :ticket_type, 	presence: true
	
end
