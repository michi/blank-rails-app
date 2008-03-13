require File.dirname(__FILE__) + '/../../test_helper'

class Admin::ProfileControllerTest < ActionController::TestCase
  def test_show
    get_with_session :show
    assert_redirected_to edit_admin_profile_path
  end
  
  def test_edit
    get_with_session :edit
    assert_response :success
    assert_equal users(:august), assigns(:user)
  end
  
  def test_successful_update
    post_with_session :update, :user => {:username => "newusername"}
    assert_redirected_to edit_admin_profile_path
  end
  
  def test_failed_update
    post_with_session :update, :user => {:username => nil}
    assert !assigns(:user).valid?
    assert_response :success
  end
  
  def test_reset_password
    user = users(:august)
    old_password = user.password_hash.dup
    
    post_with_session :reset_password
    assert_not_equal user.reload.password_hash, old_password
    assert_redirected_to edit_admin_profile_path
  end
end
