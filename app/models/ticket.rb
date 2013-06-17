# == Schema Information
#
# Table name: tickets
#
#  id              :integer          not null, primary key
#  description     :string(255)
#  state           :string(255)
#  closing_token   :string(255)
#  resolution_date :datetime
#  closed_date     :datetime
#  user_id         :integer
#  ticket_type_id  :integer          default(2)
#  category_id     :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class Ticket < ActiveRecord::Base
	attr_accessible :description, :category_id, :resolution_date, :ticket_type_id

	default_scope order('created_at DESC')

	scope :past_due, lambda { where("resolution_date < ?", Time.now ) }
	scope :pending, where("state != 'Cerrado' AND state != 'Marcado como cerrado'")
	scope :completed, where("state = 'Cerrado' OR state = 'Marcado como cerrado'")

	has_many :logs, dependent: :destroy

	has_one :assignment, dependent: :destroy
	has_one :assigned_tech, through: :assignment, source: :user
	has_one :survey, dependent: :destroy
	
	belongs_to :user
	belongs_to :category
	belongs_to :type, class_name: "TicketType", foreign_key: "ticket_type_id"
	
	validates :description, 	presence: true, length: { maximum: 200 }
	validates :user_id, 		presence: true
	validates :category_id, 		presence: true

	before_save :create_closing_token

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
		create_assignment(user_id: user.id)
		self.assign!
	end

	def deallocate_from(user)
		assignment.find_by_user_id(user.id).destroy
	end

	def deallocate
		assignment.destroy
	end

	def reassign_to(user)
		deallocate
		create_assignment(user_id: user.id)
		self.reassign!
	end

	def confirm_closed
		self.closed_date = Time.now
		self.close!
	end

	def to_csv(options = {})
		CSV.generate(options) do |csv|
			csv << column_names
			all.each do |ticket|
				csv << ticket.attributes.values_at(*column_names)
			end
		end
	end

	private
	
	def create_closing_token
		self.closing_token = SecureRandom.urlsafe_base64
	end

end
