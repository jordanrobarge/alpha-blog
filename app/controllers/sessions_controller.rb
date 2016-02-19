class SessionsController < ApplicationController

  def new
    
  end
  
  def create 
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      #this is cause id to be stored by browser and use cookies
      session[:user_id] = user.id
      flash[:success] = "You have successfully logged in"
      redirect_to user_path(user)
    else
      #page is not changing so using regular flash message would persist to next page
      flash.now[:danger] = "There was something wrong with your login info"
      render 'new'
    end
  end
  
  def destroy
    session[:user_id] = nil
    flash[:success] = "You have logged out"
    redirect_to root_path
  end
end
