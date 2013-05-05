class TicketMailer < ActionMailer::Base
	default from: "jcarmonaguerra@gmail.com"

	def opened_ticket_confirmation(ticket)
		@ticket = ticket
		mail(:to => @ticket.user.email, :subject => "Hemos recibido tu ticket ##{@ticket.id}!!!")
	end

	def hold_ticket_confirmation(ticket)
		@ticket = ticket
		mail(:to => @ticket.user.email, :subject => "Tu ticket ##{@ticket.id} ha sido colocado en estado de espera!!!")
	end

	def closing_ticket_confirmation(ticket)
		@ticket = ticket
		mail(:to => @ticket.user.email, :subject => "Tu ticket ##{@ticket.id} ha sido resuelto!")
	end
end
