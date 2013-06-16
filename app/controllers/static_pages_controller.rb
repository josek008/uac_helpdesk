class StaticPagesController < ApplicationController
	
	def home
		@categories = Category.top.limit(5).all
		@departments = Department.top.limit(5).all
		@tickets_per_day_chart = tickets_per_day_chart
		@tickets_per_dept = tickets_per_dept_chart
	end

	def help
	end

	def about
	end

	def contact_us
	end
	
end
