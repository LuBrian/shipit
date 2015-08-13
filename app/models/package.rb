class Package < ActiveRecord::Base
  has_one :driver, through: :users
  has_one :customer, through: :users

end
