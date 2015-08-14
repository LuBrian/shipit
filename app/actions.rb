## USER PAGES ##
require 'pry'
helpers do

  def current_user
    # who is logged in
    User.find_by(id: session[:id]) if session[:id]
  end

  def get_user(email, password_hash)
    user = User.find_by(email: email)

    if user && user.password_hash == password_hash
      session[:id] = user.id
      user
    end
  end

  def not_found 
    status 404
    erb :oops
  end

  def can_assign_package?
    @package.driver_id.nil? && @current_user.is_a?(Driver)
  end

  def is_session_valid?
    redirect '/login' unless session[:id]
  end 

  def can_cancel? 
    @package.driver_id == @current_user.id
  end 

  def can_pickup?
    @package.driver_id == @current_user.id
  end 

  def can_deliver?
    @package.driver_id == @current_user.id && @package.pick_up_time
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
  @current_user = current_user
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
    @current_user = current_user
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
    @current_user = current_user
		erb :'profile'
	else
		erb :'signup_driver'
	end
end

get '/dashboard' do #show all packages /packages
  # display all packages
  is_session_valid?
  erb :'/packages/index'
end

get '/profile' do
  #change this to redirect to homepage
  is_session_valid?
  @current_user = current_user
  # @current_user
  erb :'profile'
end

get '/profile/edit' do
  is_session_valid?
  @current_user = current_user
  erb :'edit'
  #get file from Brian
end

# after successful edit
put '/profile' do
  is_session_valid?
end

delete '/profile' do
  is_session_valid?
end


## CUSTOMER/DRIVER PAGES ## 


get '/packages/new'do
  is_session_valid?
  @current_user = current_user 
  if @current_user.is_a?(Customer)
    @package = Package.new
    erb :'/packages/new'
  else 
    redirect '/'
  end 
end 

post '/packages/new' do 
  is_session_valid?
  @current_user = current_user 
  if @current_user.is_a?(Customer)
    @package = Package.create(
      title: params[:title],
      recipient: params[:recipient],
      origin: params[:origin],
      destination: params[:destination],
      length: params[:length],
      width: params[:width],
      height: params[:height],
      notes: params[:notes],
      customer_id: @current_user.id
      )
  else
    redirect '/'
  end 

  if @package.persisted?
    redirect "/packages/#{@package.id}"
  else
    erb :'/packages/new'
  end
end 


#this is where you can see the edit button
get '/packages/:id' do
  is_session_valid?
  @current_user = current_user
  @package = Package.find_by(id: params[:id]) 
  if @package
    erb :'/packages/show'
  else 
    not_found
  end 
end 

post '/packages/:id' do
  is_session_valid?
  @current_user = current_user 
  @package = Package.find_by(id: params[:id]) 
  if @package
    event = params[:event]

    case event 
    when "assign"
      if can_assign_package?
        @package.driver_id = @current_user.id
        @package.assigned_time = Time.now.in_time_zone("Pacific Time (US & Canada)") 
        @package.save 
      end 
    when "cancel"
      if can_cancel? #if you are assigned
        @package.driver_id = nil 
        @package.assigned_time = nil
      end 
    when "picked_up"
      if can_pickup? #if you are assigned
        @package.pick_up_time = Time.now.in_time_zone("Pacific Time (US & Canada)")
        @package.save
      end 
    when "delivered"
      if can_deliver? #if you have picked up && assigned
        @package.delivery_time = Time.now.in_time_zone("Pacific Time (US & Canada)")
        @package.save
      end 
    end 
    erb :'/packages/show'
  else 
    not_found
  end 
  
end 

#this is where you redirect to when you click the edit button
get '/packages/:id/edit' do
  is_session_valid?
  @current_user = current_user
  @package = Package.find_by(id: params[:id])
  if @current_user.id == @package.user_id 
    erb :'/packages/edit'
  else 
    redirect '/'
  end 
end 

# this is where you see the edit form
## !! Must only be available to CUSTOMERS 
put '/packages/:id' do 
  is_session_valid?
  @current_user = current_user
  if @current_user.is_a?(Customer)
    @package = Package.find_by(id: params[:id])
    if @package && @current_user.id == @package.user_id 
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
    else 
      redirect '/'
    end 
  end 
  # DRIVER ACCEPTING ABILITIES 


end 

delete '/packages/:id' do 
  # ensure that only the owner of the package can delete it 
  is_session_valid?
  @current_user = current_user
  @package = Package.find_by(id: params[:id])
  if @package && @current_user.id == @package.user_id 
    @package.destroy
  end 
  # redirect doesn't work yet, waiting on index page
  redirect '/packages/index'
end 



