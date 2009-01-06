class Program < ActiveRecord::Base
  @@program_types = ["Music", "Public Affairs"].freeze
  cattr_accessor :program_types
  
  acts_as_textiled :description
  
  default_scope :order => 'name DESC'
  
  has_and_belongs_to_many :users
  
  has_many :playlists, :order => 'starts_at DESC'
  
  has_many :slots,     :order => 'created_at DESC'
  has_many :schedules, :through => :slots, :order => 'created_at DESC'
  has_many :promos,    :as => :promotable
  
  searchify :name, :description, :promos => [:body], :users => [:first_name, :last_name, :dj_name]
    
  validates_presence_of     :name
  validates_uniqueness_of   :name
  
  def to_param
    return "#{self.id}-#{self.name.gsub(/\W/, '')}"
  end  

  def to_s
    self.name
  end
  
  def type
    self["type"] || ""
  end
  
  def description
    self[:description] || self.promos.first.body rescue ""
  end
end

class MusicProgram         < Program; end
class PublicAffairsProgram < Program; end