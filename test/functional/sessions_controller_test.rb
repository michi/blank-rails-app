require File.dirname(__FILE__) + '/../test_helper'

class SessionsControllerTest < ActionController::TestCase
  
  def test_get_new
    get :new
    assert_response :success
  end
  
  def test_redirects_to_admin_when_logged_in
    get_with_session :new
    assert_redirected_to root_url
  end
  
  def test_invalid_login_credentials
    post :create, :user => {:username => "august", :password => "definately invalid"}
    assert_response :success
    assert_template "sessions/new"
  end
  
  def test_valid_login_credentials
    post :create, :user => {:username => "august", :password => "12345"}
    assert_redirected_to root_url
    assert_equal users(:august), @controller.current_user
  end
  
  def test_log_out
    post_with_session :destroy
    assert_nil session[:user]
    assert_redirected_to root_url
  end
end
