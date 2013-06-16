module TicketsHelper

	def tickets_per_day
		tickets_day = []
		days = (29.days.ago.to_date..Date.today).to_a
		days.each do |d|
			tickets_day << Ticket.find(:all, :conditions => ["created_at BETWEEN ? AND ?", d.to_time.at_beginning_of_day, d.to_time.end_of_day]).count
		end
		tickets_day
	end

	def tickets_per_day_chart
		@data = tickets_per_day

		@h = LazyHighCharts::HighChart.new('graph') do |f|
			f.options[:title][:text] = "Tickets por dia"
			f.options[:subtitle][:text] = "Ultimos 30 dias"
			f.options[:chart][:defaultSeriesType] = "line"
			f.options[:chart][:inverted] = false
			f.options[:chart][:zoomType] = 'x'
			f.options[:legend][:layout] = "horizontal"
			f.options[:legend][:borderWidth] = "0"
			f.series(:pointInterval => 1.day, :pointStart => 29.days.ago.to_date, :name => '# de Tickets', :color => "#2cc9c5", :data => @data )
			f.options[:xAxis] = {:minTickInterval => 1, :type => "datetime", :dateTimeLabelFormats => { day: "%b %e"}, :title => { :text => nil }, :labels => { :enabled => true } }
			f.options[:yAxis] = {:title => {:text => "# de Tickets"}, :min => 0}
		end

		@h
	end

	def tickets_per_dept_chart
		@departments = Department.top.limit(5).all

		@h = LazyHighCharts::HighChart.new('graph') do |f|
			f.options[:title][:text] = "Tickets por Departamento"
			f.options[:subtitle][:text] = "#{Date.today.strftime("%B")}"
			f.options[:chart][:defaultSeriesType] = "column"
			f.options[:chart][:inverted] = false
			f.options[:legend][:layout] = "horizontal"
			f.options[:legend][:borderWidth] = "0"
			@departments.each do |d|
				f.series(:name => d.name, :data => [d.tickets.count])
			end
			f.options[:xAxis] = {:categories => ["#{Date.today.strftime("%B")}"]} 
			f.options[:yAxis] = {:title => {:text => "# de Tickets"}, :minTickInterval => 1}
		end

		@h
	end

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