# == Schema Information
#
# Table name: categories
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  parent_id  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Category < ActiveRecord::Base
	attr_accessible :name, :parent_id

	scope :is_subcategory, where('parent_id IS NOT NULL')
	scope :top,
		select("categories.id, categories.name, count(tickets.id) AS tickets_count").
		joins(:tickets).
		group("categories.id").
		order("tickets_count DESC")

	has_many :tickets
	has_many :subcategories, class_name: "Category", foreign_key: "parent_id", dependent: :destroy
	belongs_to :parent, class_name: "Category"
	
	validates :name, presence: true, uniqueness: true

	def complete_name
		name = "#{self.parent.name} / #{self.name}"
	end
end
