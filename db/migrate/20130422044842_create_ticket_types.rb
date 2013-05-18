class CreateTicketTypes < ActiveRecord::Migration
  def change
    create_table :ticket_types do |t|
      t.string :description

      t.timestamps
    end

    add_index :ticket_types, :description, unique: true
  end
end
