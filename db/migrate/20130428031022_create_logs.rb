class CreateLogs < ActiveRecord::Migration
  def change
    create_table :logs do |t|
      t.integer :user_id
      t.integer :ticket_id
      t.string  :event
      t.string  :content

      t.timestamps
    end
  end
end
