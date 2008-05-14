require File.dirname(__FILE__) + '/../test_helper'

class ResetPasswordControllerTest < ActionController::TestCase
  def test_invalid_username
    post_with_session :create, :username => "has no clue"
    assert_template "reset_password/show"
  end
  
  def test_valid_username
    user = users(:august)
    old_password = user.password_hash.dup
    
    post_with_session :create, :username => user.username
    assert_not_equal old_password, user.reload.password_hash
    assert_redirected_to root_path
  end
end
