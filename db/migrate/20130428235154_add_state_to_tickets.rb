class AddStateToTickets < ActiveRecord::Migration
  def change
  	add_column :tickets, :state, :integer
  	add_index  :tickets, :state
  end
end
