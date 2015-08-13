## USER PAGES ## 

# Homepage (Root path)
get '/' do 
  



  @driver = Driver.create(
  license: "tester",
  email: "schuo"
  )

  @customer = Customer.create(
    email: "test@gmail.com")

  erb :index

  # puts @driver.email

end 

get '/dashboard' do #show all packages /packages
  # display all packages 
  erb :'packages/index'
end 

get '/profile' do 

end 

get '/profile/edit' do

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
 




