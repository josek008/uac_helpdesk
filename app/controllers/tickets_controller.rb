# encoding: UTF-8

class TicketsController < ApplicationController

	helper_method :sort_column, :sort_direction

	before_filter :signed_in_user, 	only: [:index, :new, :create, :confirm_closed]
	before_filter :correct_user, 	only: :show
	before_filter :admin_user, 		only: [:edit, :update, :destroy, :hold, :close]

	def index
		@tickets = view_filter(params[:view_token]).paginate(page: params[:page])
		@view_token = params[:view_token]
	end

	def show
		@ticket = Ticket.find(params[:id])
		@logs = @ticket.logs.paginate(page: params[:page])
		@log = @ticket.logs.build
	end

	def search
		if @ticket = Ticket.find_by_id(params[:id])
			@logs = @ticket.logs.paginate(page: params[:page])
			@log = @ticket.logs.build
			redirect_to @ticket
		else
			@tickets = view_filter(params[:view_token]).paginate(page: params[:page])
			@view_token = params[:view_token]
			flash.now[:error] = "No existe un ticket con ese ID!"
			render 'index'
		end
	end

	def new
		@ticket = Ticket.new
		@categories = Category.where("parent_id IS NULL")
		@ticket_types = TicketType.all
	end

	def create
		@ticket = current_user.tickets.build(params[:ticket])
		@categories = Category.where("parent_id IS NULL")
		@ticket_types = TicketType.all
		
		if @ticket.save
			log_this(@ticket.id, "Abierto", params[:content])
			@tech = random_tech
			if @ticket.assign_to(@tech)
				log_this(@ticket.id, "Asignado", "Asignado automáticamente a #{@tech.name}")
				TicketMailer.opened_ticket_confirmation(@ticket).deliver
				flash[:success] = "Tu ticket ha sido creado satisfactoriamente!!"
				redirect_to root_url
			end
		else
			render 'new'
		end
	end

	def edit
		@ticket = Ticket.find(params[:id])
		@categories = Category.where("parent_id IS NULL")
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
				TicketMailer.hold_ticket_confirmation(@ticket).deliver
				flash[:success] = "Ticket puesto en estado de espera!"
			else
				flash[:error] = "No pude cambiar el estado del ticket, verifica su estado!"
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
				TicketMailer.closing_ticket_confirmation(@ticket).deliver
				flash[:success] = "Ticket marcado como cerrado!"
			else
				flash[:error] = "No pude cambiar el estado del ticket, verifica su estado!"
			end
			redirect_to @ticket
		else
			@log = Log.new
		end
	end

	def confirm_closed
		@ticket = Ticket.find(params[:id])
		if @ticket.closing_token == params[:closing_token]
			if @ticket.confirm_closed
				log_this(@ticket.id, "Cerrado", "Ticket confirmado como resuelto!")
				@survey = @ticket.create_survey!(tech_id: @ticket.assigned_tech.id, user_id: @ticket.user.id)
				redirect_to @survey
				flash[:success] = "Ticket confirmado como resuelto. Cerrando solicitud!"
			end
		else
			flash[:error] = "Hubo un inconveniente con su solicitud. Quizás el ticket ya ha sido cerrado. Verifíque!"	
			redirect_to @ticket
		end
	end

	def reassign
		@ticket = Ticket.find(params[:id])
		@technicians = User.is_tech
		if params.has_key?(:log)
			if @ticket.reassign
				@new_tech = User.find(params[:widget][:tech])
				@ticket.reassign_to(@new_tech)
				log_this(@ticket.id, "Reasignado", params[:log][:content])
				flash[:success] = "Ticket reasignado!"
			else
				flash[:error] = "No pude cambiar el estado del ticket, verifica su estado!"
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
			redirect_to @ticket
		else
			render 'edit'
		end
	end

	private

	def correct_user
		@ticket = Ticket.find(params[:id])
		redirect_to(root_path) unless current_user?(@ticket.user) || current_user.admin? || current_user.tech?
	end

	def admin_user
		redirect_to (root_path) unless current_user.admin? || current_user.tech?
	end

	def sort_column
		params[:sort] || "created_at"
	end

	def sort_direction
		params[:direction] || "desc"
	end

end
