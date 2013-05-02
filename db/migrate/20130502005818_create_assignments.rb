class CreateAssignments < ActiveRecord::Migration
  def change
    create_table :assignments do |t|
      t.integer :user_id
      t.integer :ticket_id

      t.timestamps
    end

    add_index :assignments, [:user_id, :ticket_id]
    
  end
end
