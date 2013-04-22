class CreateTickets < ActiveRecord::Migration
  def change
    create_table :tickets do |t|
      
      t.string :description

      t.datetime :resolution_date
      t.datetime :closed_date

      t.references :created_by
      t.references :ticket_status, default: 1
      t.references :ticket_type
      t.references :category
      t.references :survey_score

      t.timestamps
    end
  end
end
