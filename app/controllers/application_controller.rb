# encoding: UTF-8

class ApplicationController < ActionController::Base
	protect_from_forgery
	
	include SessionsHelper
	include LogsHelper
	include UsersHelper

	def handle_unverified_request
		sign_out
		super
	end
end
