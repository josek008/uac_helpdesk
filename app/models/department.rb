# == Schema Information
#
# Table name: departments
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Department < ActiveRecord::Base
	attr_accessible :name

	scope :top,
		select("departments.id, departments.name, count(tickets.id) AS tickets_count").
		joins(:tickets).
		group("departments.id").
		order("tickets_count DESC")

	has_many :users
	has_many :tickets, through: :users

	validates :name, presence: true, uniqueness: true
end
