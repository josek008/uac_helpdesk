class Ticket < ActiveRecord::Base
	attr_accessible :description, :category_id, :ticket_type_id

	has_many :logs
	
	belongs_to :user
	belongs_to :category
	belongs_to :survey_score
	belongs_to :ticket_type
	
	validates :description, 	presence: true, length: { maximum: 200 }
	validates :user_id, 		presence: true
	validates :category_id, 		presence: true
	validates :ticket_type_id,	 	presence: true

	state_machine initial: :opened do
		state :opened, 		value: 'Abierto'
		state :assigned, 	value: 'Asignado'
		state :reassigned, 	value: 'Reasignado'
		state :on_hold, 	value: 'En espera'
		state :marked_as_closed, value: 'Marcado como cerrado'
		state :closed, 		value: 'Cerrado'

		event :assign do
			transition :opened => :assigned
		end

		event :reassign do
			transition :on_hold => :reassigned
			transition :assigned => :reassigned
		end

		event :put_on_hold do
			transition :assigned => :on_hold
			transition :reassigned => :on_hold
		end

		event :mark_as_closed do
			transition :on_hold => :marked_as_closed
			transition :assigned => :marked_as_closed
			transition :reassigned => :marked_as_closed
		end

		event :close do
			transition :marked_as_closed => :closed
		end
	end
end
