# encoding: UTF-8

class UsersController < ApplicationController
	before_filter :signed_in_user, 	only: [:index, :edit, :update, :destroy]
	before_filter :correct_user,	only: [:edit, :update]
	before_filter :admin_user,		only: [:destroy, :assign_role, :be_tech, :be_normal, :be_tech]
	
	def index
		@users = User.all
	end

	def show
		@user = User.find(params[:id])
		@tickets = @user.tickets.paginate(page: params[:page])
	end

	def new
		@user = User.new
		@departments = Department.all
	end

	def create
		@user = User.new(params[:user])
		@departments = Department.all
		
		if @user.save
			sign_in @user
			UserMailer.welcome_user(@user).deliver
			flash[:success] = "Bienvenido a UAC Helpdesk!"
			redirect_to @user
		else
			render 'new'
		end
	end

	def edit
		@departments = Department.all
	end

	def destroy
		User.find(params[:id]).destroy
		flash[:success] = "Usuario eliminado!"
		redirect_to users_url
	end

	def update
		if @user.update_attributes(params[:user])
			flash[:success] = "Perfil actualizado."
			sign_in @user
			redirect_to @user
		else
			render 'edit'
		end
	end

	def assign_role
		@user = User.find(params[:id])
	end

	def be_tech
		@user = User.find(params[:id])
		if @user.be_tech
			flash[:success] = "Rol de Técnico asignado satisfactoriamente a #{@user.name}!"
			redirect_to users_url
		else
			flash.now[:error] = "Hubo un error en la asignación de rol. Intente nuevamente"
			render 'assign_role'
		end
	end

	def be_normal
		@user = User.find(params[:id])
		if @user.be_normal
			flash[:success] = "Rol de Usuario asignado satisfactoriamente a #{@user.name}!"
			redirect_to users_url
		else
			flash.now[:error] = "Hubo un error en la asignación de rol. Intente nuevamente"
			render 'assign_role'
		end
	end

	def be_admin
		@user = User.find(params[:id])
		if @user.be_admin
			flash[:success] = "Rol de Admin asignado satisfactoriamente a #{@user.name}!"
			redirect_to users_url
		else
			flash.now[:error] = "Hubo un error en la asignación de rol. Intente nuevamente"
			render 'assign_role'
		end
	end

	private 

	def correct_user
		@user = User.find(params[:id])
		redirect_to(root_path) unless current_user?(@user)
	end

	def admin_user
		redirect_to (root_path) unless current_user.admin?
	end
end
