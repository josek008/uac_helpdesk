class CreateSurveys < ActiveRecord::Migration
  def change
    create_table :surveys do |t|
      t.integer :ticket_id
      t.integer :tech_id
      t.integer :user_id
      t.integer :score_id
      t.string :state

      t.string :comments

      t.timestamps
    end

    add_index :surveys, [:ticket_id, :tech_id]
    add_index :surveys, :ticket_id, unique: true

  end
end
