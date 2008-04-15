require "#{File.dirname(__FILE__)}/../test_helper"

class PasswordResetTest < ActionController::IntegrationTest
  def test_random_stuff
    dude = session_dude
    dude.visits_index
    dude.shows_login
    dude.logs_in
    dude.shows_profile
    dude.asks_for_password_reset
  end
  
  private
  
  def session_dude
    open_session do |session|
      class << session
        def visits_index
          get "/"
          assert_response :success
          assert_template "index/index"
        end
        
        def shows_login
          get "/login"
          assert_response :success
        end
        
        def logs_in
          post "/sessions/create", :user => {:username => "august", :password => "12345"}
          assert_response :redirect
        end
        
        def shows_profile
          get "/profile"
          assert_redirected_to edit_profile_path
        end
        
        def asks_for_password_reset
          old_password = @controller.current_user.password_hash.dup
          
          get "/profile/reset_password"
          assert_response :redirect
          assert_not_equal old_password, assigns(:user).reload.password_hash
        end
      end
    end
  end
end
