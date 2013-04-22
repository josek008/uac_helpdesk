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

end
