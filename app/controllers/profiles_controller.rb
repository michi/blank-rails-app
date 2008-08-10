class ProfilesController < ApplicationController
  before_filter :login_required, :except => [:new, :create, :forgot_password, :reset_password]
  verify :method => :put, :only => :reset_password
  
  def show
    redirect_to edit_profile_path
  end
  
  def new
    @user = User.new
  end
  
  def edit
    @user = current_user
  end
  
  def create
    @user = User.new(params[:user])
    @user.save!
    self.current_user = @user
    redirect_to_stored_location_or_default root_path
  end
  
  def update
    @user = current_user
    @user.update_attributes!(params[:user])
    redirect_to edit_profile_path
  end
  
  def forgot_password
    render
  end
  
  def reset_password
    @user = User.find_for_password_reset(params[:user][:identification])
    
    if @user
      @user.reset_password!
      flash[:success] = "Your password has ben reset! A new password has been sent to your e-mail address."
      redirect_to login_path
    else
      flash[:error] = "Could not find a user by that username, full name or email."
      render :action => "forgot_password"
    end
  end
end
