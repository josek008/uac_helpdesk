class CreateScores < ActiveRecord::Migration
	def change
		create_table :scores do |t|
			t.string :description

			t.timestamps
		end

		add_index :scores, :description, unique: true
	end
end
