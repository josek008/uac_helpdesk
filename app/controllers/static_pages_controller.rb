class StaticPagesController < ApplicationController
	
	def home
		@categories = Category.top.limit(5).all
		@departments = Department.top.limit(5).all
	end

	def help
	end

	def about
	end

	def contact_us
	end
	
end
