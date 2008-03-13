require File.dirname(__FILE__) + '/../../test_helper'

class Admin::ProfileControllerTest < ActionController::TestCase
  def test_edit
    get_with_session :edit
    assert_equal users(:august), assigns(:user)
  end
  
  def test_successful_update
    post_with_session :update, :user => {:username => "newusername"}
    assert_redirected_to admin_profile_path
  end
  
  def test_failed_update
    post_with_session :update, :user => {:username => nil}
    assert !assigns(:user).valid?
    assert_response :success
  end
end
