ActionController::Routing::Routes.draw do |map|
  map.with_options :name_prefix => nil do |section|  
    section.namespace :music do |music|
      music.music_root '/', :controller => :music
      
      music.resources :artists
      music.resources :albums, :has_one => [:review]
      music.resources :labels
      music.resources :formats
      music.resources :genres
      music.resources :playlists, :has_many => [:plays]
    end
  
    section.namespace :programming do |programming|
      programming.programming_root '/', :controller => :programming
      
      programming.resources :programs, :has_many => [:playlists]
      programming.resources :psas, :controller => "PSA"
      programming.resources :promos
      programming.resources :schedules, :has_many => [:programs, :slots]
      programming.resources :events
    end
  
    section.namespace :calendar do |calendar|
      calendar.calendar_root '/', :controller => :calendar
      
      calendar.with_options :controller => 'events', :action => 'index' do |events|
        events.connect ':year/:month',  :year => /\d{4}/, :month => /\d{1,2}/ 
      end
    end
  
    section.namespace :staph do |staph|
      staph.staph_root '/', :controller => :staph
      
      staph.resources :users
      staph.resources :roles
    end
  end
  
  map.search      'search',   :controller => 'search', :action => 'query'
  map.live_search 'search/live', :controller => 'search', :action => 'remote_live_search'

  map.resources :sessions
  map.login   'login',  :controller => 'sessions', :action => 'new'
  map.logout  'logout', :controller => 'sessions', :action => 'destroy'

  map.root :controller => 'welcome', :action => 'index'
  
  # Install the default route as the lowest priority.
  map.connect ':controller/:action/:id.:format'
  map.connect ':controller/:action/:id'
end
