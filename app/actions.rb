## USER PAGES ##
require 'pry'
helpers do

  def current_user
    # who is logged in
    @current_user = User.find(session[:id]) if session[:id]
  end

  def get_user(email, password_hash)
    user = User.find_by(email: email)

    if user && user.password_hash == password_hash
      session[:id] = user.id
      user
    end
  end

end 

configure do
  enable :sessions
end

get '/' do
  erb :index
end

get '/login' do
	erb :login
end


post '/login' do
  @user = get_user(params[:email], params[:password_hash])
  current_user
  if !@user.nil?
    erb :'profile'
  else
	  #@messages is in the login .erb (see below)
    @messages = ['Invalid login credentials']
    erb :'/login'
  end

end

get '/logout' do
	session.clear
	redirect to('/')
end


get '/signup_customer' do
	erb :'signup_customer'
end

get '/signup_driver' do
	erb :'signup_driver'
end

post '/signup_customer' do
	@user = Customer.new(
    first_name: params[:first_name],
    last_name: params[:last_name],
		email: params[:email],
		password_hash: params[:password_hash],
		phone_number: params[:phone_number]
	)
	if @user.save
    session[:id] = @user.id
    current_user
		erb :'profile'
	else
		erb :'signup_customer'
	end
end


post '/signup_driver' do
	@user = Driver.create(
    first_name: params[:first_name],
    last_name: params[:last_name],
		email: params[:email],
		password_hash: params[:password_hash],
		phone_number: params[:phone_number],
    license: params[:license],
    license_expiry: params[:license_expiry],
    province: params[:province]
	)
	if @user.save
  # if @user.persisted? 
    session[:id] = @user.id
    current_user
		erb :'profile'
	else
		erb :'signup_driver'
	end
end

get '/dashboard' do #show all packages /packages
  # display all packages
  erb :'/packages/index'
end

get '/profile' do
  #change this to redirect to homepage
  halt 401, "not allowed" unless session[:id]
  current_user
  # @current_user
  erb :'profile'
end

get '/profile/edit' do
  current_user
  erb :'edit'
end

# after successful edit
put '/profile' do
end

delete '/profile' do
end


## CUSTOMER/DRIVER PAGES ## 


get '/packages/new'do
  @package = Package.new
  erb :'/packages/new'
end 

post '/packages/new' do 
  @package = Package.create(
    title: params[:title],
    recipient: params[:recipient],
    origin: params[:origin],
    destination: params[:destination],
    length: params[:length],
    width: params[:width],
    height: params[:height],
    notes: params[:notes],
    ready_for_pickup: true,
    accepted: false,
    picked_up: false,
    delivered: false
    )

  if @package.persisted?
    redirect "/packages/#{@package.id}"
  else
    erb :'/packages/new'
  end
end 


#this is where you can see the edit button
get '/packages/:id' do
  current_user
  @package = Package.find(params[:id])
  erb :'/packages/show'
end 

#this is where you redirect to when you click the edit button
get '/packages/:id/edit' do
  @package = Package.find(params[:id])
  erb :'/packages/edit'
end 

# this is where you see the edit form
## !! Must only be available to CUSTOMERS 
put '/packages/:id' do 
  # CUSTOMER EDITING ABILITIES 
  @package = Package.find(params[:id])
  if @package.update(
    title: params[:title],
    recipient: params[:recipient], 
    origin: params[:origin],
    destination: params[:destination],
    length: params[:length],
    width: params[:width],
    height: params[:height],
    notes: params[:notes]
    )
    erb :'/packages/show'
  else 
    erb :'/packages/edit'
  end 
  # DRIVER ACCEPTING ABILITIES 


end 

delete '/packages/:id' do 
  # ensure that only the owner of the package can delete it 
  @package = Package.find(params[:id])
  @package.destroy
  # redirect doesn't work yet, waiting on index page
  redirect '/packages/index'
end 



