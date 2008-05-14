class ResetPasswordController < ApplicationController
  def show
    render
  end
  
  def create
    @user = User.find_by_username(params[:username])
    
    if @user
      @user.reset_password!
      flash[:success] = "A new password has been created and sent to you via e-mail."
      redirect_to root_path
    else
      flash[:error] = "Could not find a user matching that username."
      render :action => "show"
    end
  end
end
