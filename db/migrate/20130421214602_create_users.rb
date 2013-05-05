class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :password_digest
      t.string :remember_token
      t.boolean :tech, default: false
      t.boolean :admin, default: false
      t.integer :department_id
      
      t.timestamps
    end

    add_index :users, :email, unique: true
    add_index :users, :remember_token, unique: true

  end
end
