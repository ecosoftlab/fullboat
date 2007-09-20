ActionController::Routing::Routes.draw do |map|
  map.resources :underwriting_contracts

  map.resources :plays

  map.resources :tags
  
  map.resources :psas

  map.resources :promos

  map.resources :playlists

  map.resources :schedules

  map.resources :contributors

  map.resources :programs

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
