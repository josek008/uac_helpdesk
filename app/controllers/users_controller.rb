# encoding: UTF-8

class UsersController < ApplicationController
	before_filter :signed_in_user, 	only: [:index, :edit, :update, :destroy]
	before_filter :correct_user,	only: [:edit, :update, :show]
	before_filter :admin_user,		only: :destroy
	
	def index
		@users = User.paginate(page: params[:page])
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

	private 

	def correct_user
		@user = User.find(params[:id])
		redirect_to(root_path) unless current_user?(@user) || current_user.admin?
	end

	def admin_user
		redirect_to (root_path) unless current_user.admin?
	end
end
