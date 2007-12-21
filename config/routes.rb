ActionController::Routing::Routes.draw do |map|
  map.resources :roles,
                :collection => {:manage => :get}
                
  map.resources :reviews,
                :collection => {:manage => :get}

  map.resources :albums,
    :collection => {:manage => :get} do |album|
    album.resource :review,
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

  map.login   'login', :controller => 'sessions', :action => 'new'
  map.logout  'logout', :controller => 'sessions', :action => 'destroy'

  # Install the default route as the lowest priority.
  map.connect ':controller/:action/:id.:format'
  map.connect ':controller/:action/:id'
end
