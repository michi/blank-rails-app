class Admin::ProfileController < Admin::IndexController
  def show
    redirect_to edit_admin_profile_path
  end
  
  def edit
    @user = current_user
  end
  
  def update
    @user = current_user
    @user.update_attributes!(params[:user])
    redirect_to edit_admin_profile_path
  end
  
  def reset_password
    @user = current_user
    @user.reset_password!
    flash[:success] = "Your password has ben reset! Instructions on how to complete the reset procedure has been sent to your e-mail address."
    redirect_to edit_admin_profile_path
  end
end
