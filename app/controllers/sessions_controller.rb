class SessionsController < ApplicationController
  before_filter :login_required, :only => [:destroy]
  
  def new
    logged_in? ? redirect_to(root_url) : render
  end
  
  def create
    self.current_user = User.authenticate(params[:user][:username], params[:user][:password])

    if logged_in?
      redirect_to root_url
    else
      flash.now[:error] = "Invalid username/password combination"
      render :action => "new"
    end
  end
  
  def destroy
    self.current_user = nil
    redirect_to root_url
  end
end
