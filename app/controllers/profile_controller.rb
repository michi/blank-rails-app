class ProfileController < IndexController
  def show
    redirect_to edit_profile_path
  end
  
  def edit
    @user = current_user
  end
  
  def update
    @user = current_user
    @user.update_attributes!(params[:user])
    redirect_to edit_profile_path
  end
end
