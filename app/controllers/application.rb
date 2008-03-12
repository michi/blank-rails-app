class ApplicationController < ActionController::Base
  include Auth
  helper :all
  protect_from_forgery
end
