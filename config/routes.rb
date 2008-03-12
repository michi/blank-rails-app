ActionController::Routing::Routes.draw do |map|
  map.login 'login', :controller => "sessions", :action => "new"
  map.logoit 'logoit', :controller => "sessions", :action => "destroy"
  
  map.root :controller => "index"
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
