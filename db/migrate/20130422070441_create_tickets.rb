class CreateTickets < ActiveRecord::Migration
  def change
    create_table :tickets do |t|

      t.string :description
      t.string :state
      t.string :closing_token

      t.datetime :resolution_date
      t.datetime :closed_date

      t.integer :user_id
      t.integer :ticket_type_id, default: 2
      t.integer :category_id

      t.timestamps

    end

    add_index  :tickets, :state
    add_index  :tickets, :closing_token, unique: true

  end
end
