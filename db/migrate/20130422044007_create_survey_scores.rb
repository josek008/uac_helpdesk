class CreateSurveyScores < ActiveRecord::Migration
	def change
		create_table :survey_scores do |t|
			t.string :survey_descr

			t.timestamps
		end

		add_index :survey_scores, :survey_descr, unique: true
	end
end
