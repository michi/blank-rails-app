class Admin::ProfileController < Admin::IndexController
  def edit
    @user = current_user
  end
  
  def update
    @user = current_user
    @user.update_attributes!(params[:user])
    redirect_to admin_profile_path
  end
end
