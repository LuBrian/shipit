class Package < ActiveRecord::Base
  has_one :driver, through: :users
  has_one :customer, through: :users

  validates :title, :recipient, :origin, :destination, :length, :width, :height, presence: true 
 

end
