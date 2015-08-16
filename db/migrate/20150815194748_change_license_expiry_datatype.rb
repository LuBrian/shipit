class ChangeLicenseExpiryDatatype < ActiveRecord::Migration
  def change
    remove_column :packages, :license_expiry
    add_column :packages, :license_expiry, :string
  end
end
