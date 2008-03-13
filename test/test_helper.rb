ENV["RAILS_ENV"] = "test"
require File.expand_path(File.dirname(__FILE__) + "/../config/environment")
require 'test_help'

class Test::Unit::TestCase
  self.use_transactional_fixtures = true
  self.use_instantiated_fixtures  = false
  fixtures :all
end

module ControllerTestHelper
  def get_with_session(action, params=nil, session={}, flash=nil)
    session.update(:user => users(:august).id)
    get(action, params, session, flash)
  end

  def post_with_session(action, params=nil, session={}, flash=nil)
    session.update(:user => users(:august).id)
    post(action, params, session.update({:current_user_id => users(:august).id}), flash)
  end
end


ActionController::TestCase.class_eval { include ControllerTestHelper }
