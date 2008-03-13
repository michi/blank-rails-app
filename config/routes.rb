ActionController::Routing::Routes.draw do |map|
  map.login 'login', :controller => "sessions", :action => "new"
  map.logoit 'logoit', :controller => "sessions", :action => "destroy"
  
  map.namespace :admin do |admin|
    admin.root :controller => "index"
    admin.resource :profile, :controller => "profile"
  end
  
  map.root :controller => "index"
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
