#Note we have generated a controller that doesnt use a model
#This will leverage a form not associated with a model object

class SessionsController < ApplicationController
  skip_before_action :authorize
  skip_before_action :admin
  def new
  end

##Directing Joe to admin page and other 
##users to the normal page
  def create
  user=User.find_by(name: session[:name])
  if session[:name] == 'Tom' and user.try(:authenticate,(params[:password]))
  	session[:user_id] = user.id
  	session[:name] = user.name
  	redirect_to admin_url  
  else if user and user.authenticate(params[:password])
  redirect_to new_thing_url
  else
  redirect_to login_url, alert: "Invalid user/password combo"
  end 
  end
  
  end
  

  def destroy
  session[:user_id]= nil
  redirect_to login_url, notice: "Logged out"
  end
end
