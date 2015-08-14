class AddColumnsToUsersAndPackages < ActiveRecord::Migration
  def change
    add_column :users, :avatar, :string 
    add_column :packages, :recipient, :string 
    add_column :packages, :created_at, :datetime
    add_column :packages, :updated_at, :datetime
  end
end
