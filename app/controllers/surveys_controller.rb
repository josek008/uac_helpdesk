# encoding: UTF-8

class SurveysController < ApplicationController
	before_filter :correct_user, only: [:show, :answer]
	before_filter :admin_user, only: :index

	def show
		@survey = Survey.find(params[:id])
		@ticket = @survey.ticket
		@scores = Score.all
	end

	def answer
		@survey = Survey.find(params[:id])
		@comments = params[:survey][:comments]
		@score = Score.find(params[:survey][:score])

		if @survey.answer_survey(@comments, @score)
			flash[:success] = "Encuesta registrada! Gracias por calificar nuestro servicio!"
		else
			flash[:error] = "Hubo un problema con tu solicitud. Tal vez la encuesta ya fue registrada!"
		end

		redirect_to @survey.ticket
	end

	def index
		@surveys = Survey.paginate(page: params[:page])
	end

	private 

	def correct_user
		@survey = Survey.find(params[:id])
		redirect_to(root_path) unless current_user?(@survey.user)
	end

	def admin_user
		redirect_to (root_path) unless current_user.admin?
	end

end
