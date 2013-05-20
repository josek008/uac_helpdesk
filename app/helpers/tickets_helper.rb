module TicketsHelper

	def view_filter(view_token)
		case view_token
		when "my-opened-tickets" then current_user.tickets.pending
		when "my-tickets-on-hold" then current_user.tickets.find_all_by_state("En espera")
		when "my-resolved-tickets" then current_user.tickets.completed
		when "my-closed-tickets" then current_user.tickets.find_all_by_state("Cerrado")
		when "my-expired-tickets" then current_user.tickets.pending.past_due
		when "my-tickets" then current_user.tickets

		when "assigned-opened-tickets" then current_user.assigned_tickets.pending
		when "assigned-tickets-on-hold" then current_user.assigned_tickets.find_all_by_state("En espera")
		when "assigned-resolved-tickets" then current_user.assigned_tickets.completed
		when "assigned-closed-tickets" then current_user.assigned_tickets.find_all_by_state("Cerrado")
		when "assigned-expired-tickets" then current_user.assigned_tickets.pending.past_due
		when "assigned-tickets" then current_user.assigned_tickets

		when "opened-tickets" then Ticket.pending
		when "tickets-on-hold" then Ticket.find_all_by_state("En espera")
		when "resolved-tickets" then Ticket.completed
		when "closed-tickets" then Ticket.find_all_by_state("Cerrado")
		when "expired-tickets" then Ticket.pending.past_due
		when "all-tickets" then Ticket

		else current_user.tickets
			
		end
	end

	def view_name(view_token)
		case view_token
		when "my-opened-tickets" then "Mis tickets abiertos"
		when "my-tickets-on-hold" then "Mis tickets en espera"
		when "my-resolved-tickets" then "Mis tickets resueltos"
		when "my-closed-tickets" then "Mis tickets cerrados"
		when "my-expired-tickets" then "Mis tickets vencidos"
		when "my-tickets" then "Todos mis tickets"

		when "assigned-opened-tickets" then "Tickets asignados y abiertos"
		when "assigned-tickets-on-hold" then "Tickets asignados y en espera"
		when "assigned-resolved-tickets" then "Tickets asignados y resueltos"
		when "assigned-closed-tickets" then "Tickets asignados y cerrados"
		when "assigned-expired-tickets" then "Tickets asignados y vencidos"
		when "assigned-tickets" then "Tickets asignados"

		when "opened-tickets" then "Tickets abiertos"
		when "tickets-on-hold" then "Tickets en espera"
		when "resolved-tickets" then "Tickets resueltos"
		when "closed-tickets" then "Tickets cerrados"
		when "expired-tickets" then "Tickets expirados"
		when "all-tickets" then "Todos los tickets"

		else "Todos mis tickets"
			
		end
	end

	def type_class(type)
		case type
		when "Preventivo" then "label"
		when "Correctivo" then "label label-info"
		end
	end
end