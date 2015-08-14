require 'faker'
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
		license_expiry: Faker::Date.forward(2000)
	})
end

@num_customers = Customer.all.count
@num_drivers = Driver.all.count

20.times do
	Package.create({
		title: Faker::Commerce.product_name,
		origin: Faker::Address.street_address,
		recipient: Faker::Name.first_name,
		destination: Faker::Address.street_address,
		length: 1 + Random.rand(100), # cm
		width: 1 + Random.rand(100), # cm
		height: 1 + Random.rand(100), # cm
		notes: Faker::Lorem.sentence(3),
		accepted: [false, true][Random.rand(2)],
		ready_for_pickup: [false, true][Random.rand(2)],
		picked_up: [false, true][Random.rand(2)],
		delivered: [false, true][Random.rand(2)],
		customer_id: 1 + Random.rand(@num_customers - 1),
		driver_id: 1 + Random.rand(@num_drivers - 1),
	})
end