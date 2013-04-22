class SurveyScore < ActiveRecord::Base
	attr_accessible :survey_descr

	validates :survey_descr, presence: true
end
