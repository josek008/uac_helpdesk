class LogsController < ApplicationController

	def create
		ticket = Ticket.find_by_id(params[:log][:ticket_id])
		@log = ticket.logs.build(params[:log])
		@log.user_id = current_user.id
		@log.event_id = Event.find_by_event_descr("Seguimiento").id

		if @log.save
			flash[:success] = "Historial de ticket actualizado!"
			redirect_to root_url
		else
			render 'static_pages/home'
		end	
	end

	def destroy
		@log.destroy
		redirect_to root_url
	end

end
