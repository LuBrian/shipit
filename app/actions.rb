## USER PAGES ## 

# Homepage (Root path)
get '/' do 
  



  erb :index

end 

get '/dashboard' do #show all packages /packages
  # display all packages 
  erb :'/packages/index'
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




