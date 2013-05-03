# encoding: UTF-8

module UsersHelper
	# Returns the Gravatar (http://gravatar.com/) for the given user.
	def gravatar_for(user)
		gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
		gravatar_url = "https://secure.gravatar.com/avatars/#{gravatar_id}.png"
		image_tag(gravatar_url, alt: user.name, class: "gravatar")
	end

	def user_role(user)
		case
		when user.tech? then "Técnico"
		when user.admin? then "Admin"
		when !user.admin? && !user.tech? then "Usuario"
		end
	end

	def random_tech
		tech = User.is_tech.sample
	end

end
