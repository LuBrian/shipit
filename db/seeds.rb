require 'faker'
require 'date'
Faker::Config.locale = 'en-CA'

20.times do
	User.create({ 
		first_name: Faker::Name.first_name,
		last_name: Faker::Name.last_name,
		email: Faker::Internet.email,
		password_hash: Faker::Internet.password(10, 20),
		phone_number: '1234567891',
		type: ['Driver', 'Customer'][Random.rand(2)],
		license: Random.rand(1000000..9999999).to_s, province: Faker::Address.state,
		license_expiry: Faker::Date.forward(2000),
		province: Faker::Address.state,
		avatar: 'file/edwed/bob.png'
	})
end

@num_customers = Customer.all.count
@num_drivers = Driver.all.count

5.times do
	created_at = Faker::Date.between( 40.days.ago, 20.days.ago )
	updated_at = Faker::Date.between( (Date.today - created_at).days.ago, 12.days.ago )
	assigned_time = Faker::Date.between( (Date.today - created_at).days.ago, 12.days.ago )
	pick_up_time = Faker::Date.between( (Date.today - assigned_time).days.ago, 6.days.ago )
	delivery_time = Faker::Date.between( (Date.today - pick_up_time).days.ago, Date.today )
	
	Package.create({
		title: Faker::Commerce.product_name,
		origin: Faker::Address.street_address,
		recipient: Faker::Name.first_name,
		destination: Faker::Address.street_address,
		length: 1 + Random.rand(100), # cm
		width: 1 + Random.rand(100), # cm
		height: 1 + Random.rand(100), # cm
		notes: Faker::Lorem.sentence(3),
		created_at: created_at,
		updated_at: updated_at,
		assigned_time: nil,
		pick_up_time: nil,
		delivery_time: nil,
		customer_id: 1 + Random.rand(@num_customers - 1),
		driver_id: nil,
	})
end