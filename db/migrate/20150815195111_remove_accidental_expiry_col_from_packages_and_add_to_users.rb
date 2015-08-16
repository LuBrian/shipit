class RemoveAccidentalExpiryColFromPackagesAndAddToUsers < ActiveRecord::Migration
  def change
    remove_column :packages, :license_expiry
    remove_column :users, :license_expiry
    add_column :users, :license_expiry, :string
  end
end
