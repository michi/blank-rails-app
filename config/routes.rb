ActionController::Routing::Routes.draw do |map|
  map.login 'login', :controller => "sessions", :action => "new"
  map.logout 'logout', :controller => "sessions", :action => "destroy"
  
  map.resource :profile, :controller => "profile" do |p|
    p.resource :reset_password, :controller => "reset_password"
  end
  
  map.root :controller => "index"
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
