class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :event_descr

      t.timestamps
    end

    add_index :events, :event_descr, unique: true
  end
end
