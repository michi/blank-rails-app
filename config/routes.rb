ActionController::Routing::Routes.draw do |map|
  map.root :controller => "pages"
  
  map.login 'login', :controller => "sessions", :action => "new"
  map.logout 'logout', :controller => "sessions", :action => "destroy"
  map.resource :profile, :member => {:forgot_password => :get, :reset_password => :put}
    
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
  
  map.page ':action', :controller => 'pages'
end
