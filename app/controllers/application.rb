class ApplicationController < ActionController::Base
  include Auth
  helper :all
  protect_from_forgery
  session :session_key => Settings["cookie_key"], :secret => Settings["cookie_secret"]
  filter_parameter_logging :password
  
  
  rescue_from ActiveRecord::RecordInvalid, :with => :handle_invalid_record
  
  def handle_invalid_record(exception)
    exception.record.new_record? ? fallback_on_invalid_new_record : fallback_on_invalid_existing_record
  end
  
  def fallback_on_invalid_new_record
    respond_to do |format|
      format.html { render :action => ["new", "index"].detect {|a| action_methods.include?(a) } }
    end    
  end
  
  def fallback_on_invalid_existing_record
    respond_to do |format| 
      format.html { render :action => "edit" }
    end
  end
end
