class AddAdminTechToUsers < ActiveRecord::Migration
  def change
    add_column :users, :tech, :boolean, default: false
    add_column :users, :admin, :boolean, default: false
  end
end
