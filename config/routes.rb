ActionController::Routing::Routes.draw do |map|
  map.resources :events
  
  map.with_options :controller => 'events', :action => 'index' do |events|
    events.connect ':year/:month',  :year => /\d{4}/, :month => /\d{1,2}/ 
  end

  map.resources :schedules do |schedule|
    schedule.resources :slots
  end

  map.resources :promos
  map.resources :psas,
                :controller => "PSA"


  map.resources :programs do |program|
    program.resources :playlists,
                      :has_many => :plays
  end
  
  map.resources :playlists,
                :has_many => :plays
  
  # No
  map.resources :music_programs,          :controller => 'programs'
  map.resources :public_affairs_programs, :controller => 'programs'
  

  
  map.resources :albums do |album|
    album.resource  :review,
                    :collection => {:manage => :get}
    album.resources :comments,
                    :collection => { :manage => :get}
  end

  map.resources :artists
  map.resources :labels
  map.resources :formats
  map.resources :genres

  map.resources :sessions
  map.resources :users
  map.resources :roles

  map.login   'login', :controller => 'sessions', :action => 'new'
  map.logout  'logout', :controller => 'sessions', :action => 'destroy'

  map.welcome '/', :controller => 'wrct', :action => 'index'
  map.admin   'admin', :controller => 'admin', :action => 'index'
  
  map.music        'music',       :controller => 'admin', :action => 'music'
  map.programming   'programming', :controller => 'admin', :action => 'programming'
  map.exec         'exec',        :controller => 'admin', :action => 'exec'

  
  # Install the default route as the lowest priority.
  map.connect ':controller/:action/:id.:format'
  map.connect ':controller/:action/:id'
end
