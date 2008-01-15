ActionController::Routing::Routes.draw do |map|
  map.resources :programs,
                :collection => {:manage => :get} do |program|
  
    program.resources :playlists,
                      :collection => {:manage => :get}
  end
  
  map.resources :playlists,
                :has_many => :plays

  map.resources :roles,
                :collection => {:manage => :get}
                
  map.resources :reviews,
                :collection => {:manage => :get}

  map.resources :albums do |album|
    album.resource  :review,
                    :collection => {:manage => :get}
    album.resources :comments,
                    :collection => { :manage => :get}
  end

  map.resources :artists,
                :collection => {:manage => :get}

  map.resources :promoters,
                :collection => {:manage => :get}

  map.resources :labels,
                :collection => {:manage => :get}

  map.resources :formats,
                :collection => {:manage => :get}

  map.resources :genres,
                :collection => {:manage => :get}

  map.resources :sessions
  map.resources :users,
                :collection => {:manage => :get}


  map.welcome '/', :controller => 'wrct', :action => 'index'
  map.admin   'admin', :controller => 'admin', :action => 'index'
  
  map.music   'music', :controller => 'admin', :action => 'music'
  map.production   'production', :controller => 'admin', :action => 'production'
  map.exec   'exec', :controller => 'admin', :action => 'exec'

  map.login   'login', :controller => 'sessions', :action => 'new'
  map.logout  'logout', :controller => 'sessions', :action => 'destroy'

  # Install the default route as the lowest priority.
  map.connect ':controller/:action/:id.:format'
  map.connect ':controller/:action/:id'
end
