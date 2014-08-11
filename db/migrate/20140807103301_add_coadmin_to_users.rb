class AddCoadminToUsers < ActiveRecord::Migration
  def change
    add_column :users, :coadmin, :boolean, default: false
  end
end
