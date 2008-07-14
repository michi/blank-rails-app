require "#{File.dirname(__FILE__)}/../test_helper"

class PasswordResetTest < ActionController::IntegrationTest
  def test_random_stuff
    new_session :with => DudeDSL do
      visits_index
      shows_login
      fails_to_log_in
      asks_for_password_reset
    end
  end
  
  module DudeDSL
    def visits_index
      get "/"
      assert_response :success
      assert_template "pages/index"
    end
    
    def shows_login
      get "/login"
      assert_response :success
    end
    
    def fails_to_log_in
      post "/sessions/create", :user => {:username => "august", :password => "wrooong"}
      assert_template 'sessions/new'
    end
    
    def asks_for_password_reset
      user = users(:august)
      old_password = user.password_hash.dup
      
      put "/profile/reset_password", :user => {:identification => 'august'}
      assert_response :redirect
      assert_not_equal old_password, user.reload.password_hash
    end
  end
end
