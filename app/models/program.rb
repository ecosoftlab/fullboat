class Program < ActiveRecord::Base
  acts_as_textiled :description
  
  has_and_belongs_to_many :users
  
  has_many :playlists
end
