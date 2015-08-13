# Homepage (Root path)
get '/' do


  # @user = User.new(
  # first_name: "Steph",
  # last_name: "Lee",
  # email: "schuolee@gmail.com",
  # password_hash: "1234",
  # phone_number: "555-555"
  # )
  # @user.save

  # @user = User.new(
  # first_name: "Steph",
  # last_name: "Lee",
  # email: "schuo@gmail.com",
  # password_hash: "1234",
  # phone_number: "555-5555"
  # )
  #
  # @user.save
  # puts @user

  @customer = Customer.create(
  email: "tester"
  )
  # @customer.save
#   # #
  @driver = Driver.create(
  # user_id: @user.id,
  license: "12345678",
  province: "BC",
  license_expiry: "0517"
  )
# @driver = Driver.create(
#   email: "schuo@gmail.com"
# )
# puts @driver.province
#
# @driver = Driver.find(1)
# puts @driver.email

  # @driver = Driver.create
  # binding.pry
  # puts @driver.type
  erb :index
end
