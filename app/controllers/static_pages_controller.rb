class StaticPagesController < ApplicationController
	
	def home
		if signed_in?
			@tickets = current_user.tickets.paginate(page: params[:page])
			@assigned_tickets = current_user.assigned_tickets.paginate(page: params[:page])
		end
	end

	def help
	end

	def about
	end

	def contact_us
	end
	
end
