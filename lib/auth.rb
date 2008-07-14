module Auth
  def current_user
    @current_user ||= current_user_or_false
  end
  
  def current_user=(user_or_false)
    @current_user = user_or_false
    session[:user] = user_or_false[:id] rescue nil
  end
  
  def logged_in?
    current_user != false
  end
  
  def login_required
    restrict_access unless logged_in?
  end
  
  def restrict_access
    flash[:error] = "Action requires authentication."
    store_location
    redirect_to login_url
  end
  
  def redirect_to_stored_location_or_default(path)
    redirect_to(session[:stored_location] || path)
  end
  
  def self.included(base)
    base.helper_method :current_user, :logged_in?
  end
  
  private
  
  def current_user_or_false
    User.find_by_id(session[:user]) || false
  end
  
  def store_location
    session[:stored_location] = request.parameters
  end
end