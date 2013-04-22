class CreateTicketTypes < ActiveRecord::Migration
  def change
    create_table :ticket_types do |t|
      t.string :type_descr

      t.timestamps
    end

    add_index :ticket_types, :type_descr, unique: true
  end
end
