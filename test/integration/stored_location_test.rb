require "#{File.dirname(__FILE__)}/../test_helper"

class StoredLocationTest < ActionController::IntegrationTest
  def test_direct_login_without_stored_location
    new_session :with => StoredLocationDSL do
      goes_to_login
      logs_in_and_redirects_to_root
    end
  end
  
  def test_login_with_stored_location
    new_session :with => StoredLocationDSL do
      goes_to_profile_edit
      logs_in_and_is_redirected_to_profile_edit
    end
  end
  
  module StoredLocationDSL
    def goes_to_login
      get '/login'
      assert_response :success
    end
    
    def logs_in_and_redirects_to_root
      post '/sessions/create', :user => {:username => 'august', :password => '12345'}
      assert_logged_in
      assert_redirected_to root_path
    end
    
    def goes_to_profile_edit
      get '/profile'
      assert_redirected_to login_path
    end
    
    def logs_in_and_is_redirected_to_profile_edit
      post '/sessions/create', :user => {:username => 'august', :password => '12345'}
      assert_logged_in
      assert_redirected_to profile_path
    end
  end
end
