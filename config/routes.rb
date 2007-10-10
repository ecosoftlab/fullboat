ActionController::Routing::Routes.draw do |map|
  map.resources :labels

  map.resources :formats

  map.resources :genres

  map.resources :sessions
  map.resources :users,
                :collection => {:manage => :get}
  
  
  map.welcome '/', :controller => 'wrct', :action => 'index'
  map.admin   'admin', :controller => 'admin', :action => 'index'
  
  map.login   'login', :controller => 'sessions', :action => 'new'
  map.logout  'logout', :controller => 'sessions', :action => 'destroy'

  # Install the default route as the lowest priority.
  map.connect ':controller/:action/:id.:format'
  map.connect ':controller/:action/:id'
end
