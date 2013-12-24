class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
   before_action :authorize
#   

  protected
#  here we redirect people who don't have a user id to 
# the login screen
  def authorize
   	unless User.find_by(id: session[:user_id])
   		redirect_to login_url, notice: "Please log in"
   	end
   end  

##here we are trying to block admin views to non administrators   
  def admin
  	unless User.find_by(name: "Tom")
  		false
  	end
  end
    
end
