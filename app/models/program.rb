class Program < ActiveRecord::Base
  @@program_types = ["Music", "Public Affairs"].freeze
  cattr_accessor :program_types
  
  acts_as_textiled :description
  
  has_and_belongs_to_many :users
  
  has_many :promos,    :as => :promotable
  has_many :slots
  has_many :schedules, :through => :slots
  has_many :playlists
    
  validates_presence_of     :name
  validates_uniqueness_of   :name
  
  def to_param
    return "#{self.id}-#{self.name.gsub(/\W/, '')}"
  end  

  def to_s
    self.name
  end
end

class MusicProgram         < Program; end
class PublicAffairsProgram < Program; end