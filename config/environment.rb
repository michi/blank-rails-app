RAILS_GEM_VERSION = '2.0.2' unless defined? RAILS_GEM_VERSION

require File.join(File.dirname(__FILE__), 'boot')

Rails::Initializer.run do |config|
  config.action_controller.session = {
    :session_key => '_newrails_session',
    :secret      => '5aab67a574523179e0d3115e3135fd09ba5e5d1a685e07ab6d4e8f0d5c88849a715610fac801b302c5c6272e383004f6ac1dcb0dc2cf3694536c407ac981af13'
  }
end