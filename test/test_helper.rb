ENV["RAILS_ENV"] = "test"
require File.expand_path(File.dirname(__FILE__) + "/../config/environment")
require 'test_help'

class Test::Unit::TestCase
  include AuthenticatedTestHelper

  fixtures :users

  # Transactional fixtures accelerate your tests by wrapping each test method
  # in a transaction that's rolled back on completion.  This ensures that the
  # test database remains unchanged so your fixtures don't have to be reloaded
  # between every test method.  Fewer database queries means faster tests.
  #
  # Read Mike Clark's excellent walkthrough at
  #   http://clarkware.com/cgi/blosxom/2005/10/24#Rails10FastTesting
  #
  # Every Active Record database supports transactions except MyISAM tables
  # in MySQL.  Turn off transactional fixtures in this case; however, if you
  # don't care one way or the other, switching from MyISAM to InnoDB tables
  # is recommended.
  self.use_transactional_fixtures = true

  # Instantiated fixtures are slow, but give you @david where otherwise you
  # would need people(:david).  If you don't want to migrate your existing
  # test cases which use the @david style and don't mind the speed hit (each
  # instantiated fixtures translates to a database query per test method),
  # then set this back to true.
  self.use_instantiated_fixtures  = false

  
  @@artist_default_values = { :name => "Thom Yorke", 
                              :description => "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
                            }
                            
  @@album_default_values = { :name => "Hail to the Thief",
                             :artist_id => 1,
                             :label_id => 1,
                             :genre_id => 1
                           }
  @@comment_default_values = { :body => "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
                               :user_id => 1,
                               :commentable_id => 1,
                               :commentable_type => "Artist"
  }
  
  @@event_default_values = {:name => "Concert", 
                            :location => "Somewhere",
                            :description => "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
                            :starts_at => Time.now,
                            :ends_at   => Time.now + 3.hours
                            }
  @@genre_default_values = {:name => "Alternative"}
  
  @@label_default_values = {:name => "ABC Records"}
  @@playlist_default_values = {:user_id => 1, :starts_at => Time.now, :ends_at => Time.now + 1.hour}
  @@play_default_values = {:name => "[Track from an Album]", :playable_id => 1, :playable_type => "Album", :playlist_id => 1}
  @@program_default_values = {:name => "The Diving Bell", :type => "MusicProgram", :description => "From Prince to the Dirty Projectors, a veritable hodgepodge of aural delight exhumed weekly from the bottom of the ocean. The Diving Bell, Tuesday nights from 11pm-1am, only on WRCT 88.3FM"}
  @@promo_default_values = {:code => "PRO D2930-A07"}
  @@psa_default_values =   {:code => "PSA A2011-A04"}
  
  @@role_default_values = {:title => "Privileged Role"}
  
  @@review_default_values = {:body => "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
    :album_id => 1,
    :user_id => 1}
  @@slot_default_values = {:schedule_id => 1, :day => 0, :program_id => 1, :start_time => Time.now, :end_time => Time.now + 1.hour}
  @@schedule_default_values = {:name => "Regular Schedue", :description => "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.", :starts_at => Time.gm(2000, 1, 1), :ends_at => Time.gm(2000, 5, 1)}
  
  
protected 

  def loripsum(length = :default)
    case length
    when :short
      "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt."
    else
      "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
    end
  end
end
