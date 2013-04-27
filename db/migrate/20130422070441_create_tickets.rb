class CreateTickets < ActiveRecord::Migration
  def change
    create_table :tickets do |t|
      
      t.string :description

      t.datetime :resolution_date
      t.datetime :closed_date

      t.integer :user_id
      t.integer :ticket_status_id, default: 1
      t.integer :ticket_type_id
      t.integer :category_id
      t.integer :survey_score_id

      t.timestamps
    end
  end
end
