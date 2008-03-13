class Admin::IndexController < ApplicationController
  before_filter :login_required
  
  def index
    render
  end
end
