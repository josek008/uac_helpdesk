class TicketsController < ApplicationController
	before_filter :signed_in_user, 	only: [:index, :new, :create, :show]
	before_filter :admin_user, 		only: [:edit, :update, :destroy, :hold, :close]

	def index
		@tickets = current_user.tickets.paginate(page: params[:page])
	end

	def show
		@ticket = Ticket.find(params[:id])
		@logs = @ticket.logs.paginate(page: params[:page])
		@log = @ticket.logs.build
	end

	def new
		@ticket = Ticket.new
	end

	def create
		@ticket = current_user.tickets.build(params[:ticket])
		if @ticket.save
			@random_tech = random_tech
			if @ticket.assign_to(@random_tech)
				@ticket.assign!
				log_this(@ticket.id, "Asignado", "Asignado automaticamente a #{@random_tech.name}")
				log_this(@ticket.id, "Abierto", params[:content])
				flash[:success] = "Tu ticket ha sido creado satisfactoriamente!!"
				redirect_to root_url
			end
		else
			render 'new'
		end
	end

	def edit
		@ticket = Ticket.find(params[:id])
	end

	def destroy
		Ticket.find(params[:id]).destroy
		flash[:success] = "Ticket eliminado."
		redirect_to root_url
	end

	def hold
		@ticket = Ticket.find(params[:id])
		if params.has_key?(:log)
			if @ticket.put_on_hold
				log_this(@ticket.id, "En espera", params[:log][:content])
				flash[:success] = "Ticket puesto en estado de espera!"
			else
				flash[:error] = "No pude cambiar el estado al ticket, verifica su estado!"
			end
			redirect_to @ticket
		else
			@log = Log.new
		end
	end

	def close
		@ticket = Ticket.find(params[:id])
		if params.has_key?(:log)
			if @ticket.mark_as_closed
				log_this(@ticket.id, "Marcado como cerrado", params[:log][:content])
				flash[:success] = "Ticket marcado como cerrado!"
			else
				flash[:error] = "No pude cambiar el estado al ticket, verifica su estado!"
			end
			redirect_to @ticket
		else
			@log = Log.new
		end
	end

	def reassign
		@ticket = Ticket.find(params[:id])
		if params.has_key?(:log)
			if @ticket.reassign
				@new_tech = User.find(params[:widget][:tech])
				@ticket.reassign_to(@new_tech)
				log_this(@ticket.id, "Reasignado", params[:log][:content])
				flash[:success] = "Ticket reasignado!"
			else
				flash[:error] = "No pude cambiar el estado al ticket, verifica su estado!"
			end
			redirect_to @ticket
		else
			@log = Log.new
		end
	end


	def update
		@ticket = Ticket.find(params[:id])
		@ticket.category_id = params[:ticket][:category_id]

		if @ticket.save
			flash[:success] = "Ticket actualizado."
			redirect_to root_url
		else
			render 'edit'
		end
	end

	private

	def admin_user
		redirect_to (root_path) unless current_user.admin? || current_user.tech?
	end

end
