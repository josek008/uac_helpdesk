module LogsHelper

	def log_class(type)
		case type
			when "Seguimiento" 	then "label label-info"
			when "Abierto"		then "label"
			when "Cerrado"		then "label label-success"			
			when "En espera"	then "label label-important"
			when "Marcado como cerrado"	  then "label label-inverse"
			when "Asignado", "Reasignado" then "label label-warning"
		end
	end

	def log_this(ticket_id, event, content)
		@log = Log.new
		@log.ticket_id = ticket_id
		@log.event = event
		@log.content = content 
		@log.user_id = current_user.id
		@log.save	
	end

	def wrap(content)
		sanitize(raw(content.split.map{ |s| wrap_long_string(s) }.join(' ')))
	end

	private

	def wrap_long_string(text, max_width = 30)
		zero_width_space = "&#8203;"
		regex = /.{1,#{max_width}}/
		(text.length < max_width) ? text :
		text.scan(regex).join(zero_width_space)
	end
end
