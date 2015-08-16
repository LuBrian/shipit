class Driver < User
  has_many :packages 

  validates :license, presence: true
  validates :province, presence: true
  validates :license_expiry, presence: true, length: { is: 4 }
end
