ENV["RAILS_ENV"] = "test"
require File.expand_path(File.dirname(__FILE__) + "/../config/environment")
require 'test_help'
Settings['password_salt'] = '12345%s12345'

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

module IntegrationTestDSL
  def new_session(options = {}, &block)
    open_session do |sess|
      extensions = [DSLMethods]
      extensions.push(options[:with]) if options[:with]
      extensions.each {|i| sess.extend(i) }
      
      options[:subdomain] ||= 'www'
      sess.host = "#{options[:subdomain]}.local.host"
      
      block_given? ? sess.instance_eval(&block) : sess
    end
  end
  
  module DSLMethods
    def current_user
      @controller.instance_eval { current_user }
    end
    
    def assert_logged_in
      assert @controller.logged_in?
    end
  end
end

ActionController::IntegrationTest.class_eval { include IntegrationTestDSL }