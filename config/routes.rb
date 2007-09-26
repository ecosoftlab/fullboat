ActionController::Routing::Routes.draw do |map|
  map.resources :underwriting_contracts

  map.resources :plays,
                :collection => {:manage => :get}

  map.resources :tags
  
  map.resources :psas,
                :collection => {:manage => :get}

  map.resources :promos,
                :collection => {:manage => :get}

  map.resources :playlists,
                :collection => {:manage => :get}

  map.resources :schedules,
                :collection => {:manage => :get}

  map.resources :contributors,
                :collection => {:manage => :get}


  map.resources :programs,
                :collection => {:manage => :get}

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
