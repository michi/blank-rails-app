class ApplicationController < ActionController::Base
  include Auth
  helper :all
  protect_from_forgery
  session :session_key => Settings["cookie_key"], :secret => Settings["cookie_secret"]
  filter_parameter_logging :password
  
  
  rescue_from ActiveRecord::RecordInvalid, :with => :handle_invalid_record
  
  def handle_invalid_record(exception)
    record = exception.record
    
    if record.new_record?
      respond_to do |format|
        format.html { render :action => ["new", "index"].detect {|a| action_methods.include?(a) } }
      end
    else
      respond_to do |format| 
        format.html { render :action => "edit" }
      end
    end
  end
end
