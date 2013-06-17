# encoding: UTF-8

class UserMailer < ActionMailer::Base
  default from: "jcarmonaguerra@gmail.com"

	def welcome_user(user)
		@user = user
		mail(:to => @user.email, :subject => "Gracias por registrarte a UAC-Helpdesk!!!")
	end

	def reset_password_user(user)
		@user = user
		mail(:to => @user.email, :subject => "Contraseña reestablecida en UAC-Helpdesk")
	end

end
