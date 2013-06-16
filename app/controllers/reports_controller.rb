class ReportsController < ApplicationController

	def index
	end

	def per_department
		@departments = Department.top.all
		respond_to do |format|
			format.html
			format.xls
		end
	end

	def per_tech
		@tech = User.is_tech
		respond_to do |format|
			format.html
			format.xls
		end
	end

	def per_tickets
		@tickets = Ticket.order(:id)
		respond_to do |format|
			format.html
			format.xls
		end
	end

	def per_category
		@categories = Category.is_subcategory
		respond_to do |format|
			format.html
			format.xls
		end
	end

	def per_surveys
		@surveys = Survey.order(:id)
		respond_to do |format|
			format.html
			format.xls
		end
	end
	
end
