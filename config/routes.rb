ActionController::Routing::Routes.draw do |map|
  map.login 'login', :controller => "sessions", :action => "new"
  map.logout 'logout', :controller => "sessions", :action => "destroy"
  
  map.resource :profile, :controller => "profile", :member => {:forgot_password => :get, :reset_password => :put}
  
  map.root :controller => "index"
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
