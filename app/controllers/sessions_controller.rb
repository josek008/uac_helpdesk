# encoding: UTF-8

class SessionsController < ApplicationController

	def new
	end

	def create
		user = User.find_by_email(params[:session][:email].downcase)
		if user && user.authenticate(params[:session][:password])
			sign_in user
			redirect_back_or root_url
		else
			flash.now[:error] = 'Combinación inválida de email/contraseña. Verifica nuevamente.'
			render 'new'
		end
	end

	def destroy
		sign_out
		redirect_to root_path
	end

end

