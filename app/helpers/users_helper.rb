# encoding: UTF-8

module UsersHelper
	# Returns the Gravatar (http://gravatar.com/) for the given user.
	def gravatar_for(user)
		gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
		gravatar_url = "https://secure.gravatar.com/avatars/#{gravatar_id}.png"
		image_tag(gravatar_url, alt: user.name, class: "gravatar")
	end

	def random_tech
		tech = User.is_tech.sample
	end

	def random_password()
		words = %w[ foo bar jim bar col uac atl aut ]
		max = 999
		"%s%0#{max.to_s.length}d" % [ words.sample, rand(max+1) ]
	end

end
