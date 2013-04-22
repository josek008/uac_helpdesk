class CreateTicketStatuses < ActiveRecord::Migration
  def change
    create_table :ticket_statuses do |t|
      t.string :status_descr

      t.timestamps
    end

    add_index :ticket_statuses, :status_descr, unique: true
  end
end
