# == Schema Information
#
# Table name: surveys
#
#  id         :integer          not null, primary key
#  ticket_id  :integer
#  tech_id    :integer
#  user_id    :integer
#  score_id   :integer
#  state      :string(255)
#  comments   :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Survey < ActiveRecord::Base
	attr_accessible :tech_id, :ticket_id, :user_id

	belongs_to :score

	belongs_to :ticket
	belongs_to :user 
	belongs_to :tech, class_name: "User", foreign_key: "tech_id"

	validates :ticket_id, presence: true, uniqueness: true
	validates :tech_id, presence: true
	validates :user_id, presence: true

	state_machine initial: :pending do
		state :pending, value: 'Pendiente'
		state :answered, value: 'Contestada'

		event :answer do
			transition :pending => :answered
		end
	end

	def answer_survey(comments, score)
		self.comments = comments
		self.score = score
		self.answer!
	end

	def to_csv(options = {})
		CSV.generate(options) do |csv|
			csv << column_names
			all.each do |survey|
				csv << survey.attributes.values_at(*column_names)
			end
		end
	end

end
