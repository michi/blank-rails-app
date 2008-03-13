require File.dirname(__FILE__) + '/../test_helper'

class IndexControllerTest < ActionController::TestCase
  def test_get_index
    get :index
    assert_response :success
  end
end
