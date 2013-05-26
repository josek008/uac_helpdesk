class UserMailer < ActionMailer::Base
  default from: "jcarmonaguerra@gmail.com"

	def welcome_user(user)
		@user = user
		mail(:to => @user.email, :subject => "Gracias por registrarte a UAC-Helpdesk!!!")
	end

end
