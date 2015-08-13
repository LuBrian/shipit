class AddUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :password_hash
      t.string :phone_number
      t.string :type
      t.string :license
      t.string :province
      t.datetime :license_expiry
    end
  end
end
