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
      # session[:email] = user.email
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
    session[:id] = @user.id
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
  erb :'profile'
end

get '/profile/edit' do
  @user = Driver.find params[:email]
  erb :'edit'
end

# after successful edit
put '/profile' do
end

delete '/profile' do
end

## CUSTOMER PAGES ##

get '/packages/new'do
  erb :'packages/new'
end

post 'packages/new' do
  # if successful save
  erb :'packages/id'
  # else re-render form with error messages
  erb :'packages/new'
end


get '/packages/:id/edit' do
end

## for both customers and drivers
## Changes for customers and drivers
# remember to implement accept a package for drivers
put '/packages/:id' do
end

delete '/packages/:id' do
end
