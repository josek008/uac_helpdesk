# encoding: UTF-8

module ApplicationHelper

	def full_title(page_title)
		base_title = "UAC Helpdesk | Mesa de ayuda informática"
		if page_title.empty?
			base_title
		else
			"#{base_title} | #{page_title}"
		end
	end

	def state_class(type)
		case type
			when "Seguimiento" 	then "label label-info"
			when "Abierto"		then "label"
			when "Cerrado"		then "label label-success"			
			when "En espera"	then "label label-important"
			when "Marcado como cerrado"	  then "label label-inverse"
			when "Asignado", "Reasignado" then "label label-warning"
		end
	end

end
