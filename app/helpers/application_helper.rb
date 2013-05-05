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

	def state_class(state)
		case state
		when "Seguimiento" 	then "label label-info"
		when "Abierto"		then "label"
		when "Cerrado"		then "label label-success"			
		when "En espera"	then "label label-info"
		when "Marcado como cerrado"	  then "label label-inverse"
		when "Asignado", "Reasignado" then "label label-warning"
		end
	end

	def score_class(score)
		case score
		when "Muy Insatisfecho", "Insatisfecho" then "error"
		when "Satisfecho", "Muy Satisfecho"		then "success"
		when "Neutral"		then "info"
		end
	end

end
