class AddStateToTickets < ActiveRecord::Migration
  def change
  	add_column :tickets, :state, :string
  	add_index  :tickets, :state
  end
end
