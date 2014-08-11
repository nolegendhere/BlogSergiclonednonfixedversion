class AddColaboratorToUsers < ActiveRecord::Migration
  def change
    add_column :users, :colaborator, :boolean, default: false
  end
end
