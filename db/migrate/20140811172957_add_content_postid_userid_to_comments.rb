class AddContentPostidUseridToComments < ActiveRecord::Migration
  def change
    add_column :comments, :user_id, :integer
    add_column :comments, :post_id, :integer
    add_column :comments, :content, :string
  end
end
