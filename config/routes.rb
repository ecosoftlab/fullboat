ActionController::Routing::Routes.draw do |map|
  map.with_options :name_prefix => nil do |section|  
    section.namespace :music do |music|
      # music.root      :controller => 'sections', :action => 'music'
      music.resources :artists
      music.resources :albums, :has_one => [:review]
      music.resources :labels
      music.resources :formats
      music.resources :genres
      music.resources :playlists, :has_many => [:plays]
    end
  
    section.namespace :programming do |programming|
      # programming.root      :controller => 'sections', :action => 'programming'
      programming.resources :programs, :has_many => [:playlists]
      programming.resources :psas, :controller => "PSA"
      programming.resources :promos
    end
  
    section.namespace :calendar do |calendar|
      # calendar.root         :controller => 'sections', :action => 'calendar'
      calendar.resources    :schedules, :has_many => [:programs, :slots]
      calendar.resources    :events
      calendar.with_options :controller => 'events', :action => 'index' do |events|
        events.connect ':year/:month',  :year => /\d{4}/, :month => /\d{1,2}/ 
      end
    end
  
    section.namespace :staph do |staph|
      # staph.root         :controller => 'sections', :action => 'staph'
      staph.resources :users
      staph.resources :roles
    end
  end
  
  # Manually set namespacing for section indexes
  map.with_options :controller => 'sections' do |sections|
    ['music', 'programming', 'calendar', 'staph'].each do |section|
      sections.send("#{section}_root", "/#{section}", {:action => section})
    end
  end

  map.resources :sessions
  map.login   'login',  :controller => 'sessions', :action => 'new'
  map.logout  'logout', :controller => 'sessions', :action => 'destroy'

  map.root :controller => 'wrct', :action => 'index'
  
  # Install the default route as the lowest priority.
  map.connect ':controller/:action/:id.:format'
  map.connect ':controller/:action/:id'
end
