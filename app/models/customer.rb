class Customer < User
  has_many :packages #dependent: :destroy, if: :ready_for_pickup

end
