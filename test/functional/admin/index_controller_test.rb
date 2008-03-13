require File.dirname(__FILE__) + '/../../test_helper'

class Admin::IndexControllerTest < ActionController::TestCase
  def test_get_index
    get_with_session :index
    assert_response :success
  end
end
