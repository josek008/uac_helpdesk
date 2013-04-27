class TicketsController < ApplicationController
	before_filter :signed_in_user, 	only: [:index, :new, :create, :show]
	before_filter :admin_user, 		only: [:edit, :update, :destroy]

	def index
		@tickets = current_user.tickets.paginate(page: params[:page])
	end

	def show
		@ticket = Ticket.find(params[:id])
	end

	def new
		@ticket = Ticket.new
	end

	def create
		@ticket = current_user.tickets.build(params[:ticket])
		if @ticket.save
			flash[:success] = "Tu ticket ha sido creado satisfactoriamente!!"
			redirect_to root_url
		else
			render 'new'
		end
	end

	def destroy
		Ticket.find(params[:id]).destroy
		flash[:success] = "Ticket eliminado."
		redirect_to root_url
	end

	def edit
	end

	def update
		if @ticket.update_attributes(params[:ticket])
			flash[:success] = "Ticket actualizado."
			redirect_to root_url
		else
			render 'edit'
		end
	end

	private

	def admin_user
		redirect_to (root_path) unless current_user.admin?
	end

end
