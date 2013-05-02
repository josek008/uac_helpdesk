class Ticket < ActiveRecord::Base
	attr_accessible :description, :category_id, :ticket_type_id

	scope :pending, where("state != 'Cerrado' OR state != 'Marcado como cerrado'")

	has_many :logs, dependent: :destroy
	has_many :assignments, dependent: :destroy
	has_many :assigned_tech, through: :assignments, source: :user
	
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
			transition :reassigned => :reassigned
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

	def assign_to(user)
		assignments.create!(user_id: user.id)
	end

	def deallocate_from(user)
		assignments.find_by_user_id(user.id).destroy
	end

	def deallocate_from_all
		assignments.destroy_all
	end

	def reassign_to(user)
		deallocate_from_all
		assign_to(user)
	end

end
