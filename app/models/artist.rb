class Artist < ActiveRecord::Base
  acts_as_textiled :note
  
  has_many :albums
  has_many :genres, :through => :albums, :uniq => true

  validates_presence_of   :name
  validates_uniqueness_of :name
  validates_length_of     :name, :maximum => 100

  validates_presence_of   :sort_name
  validates_length_of     :sort_name, :maximum => 100
  
  before_validation_on_create :initialize_sort_name
  
  def to_param
    return "#{self.id}-#{self.name.gsub(/\W/, '')}"
  end
  
  def to_s
    self.name
  end
  
  def self.search(name)
    Artist.find(:all, :conditions => ['name LIKE ?', name.concat("%")])
  end
  
  def genre
    self.genres.first
  end
  
private

  def initialize_sort_name
    self[:sort_name] ||= self[:name].gsub(/^(the|a)\s+/i, "").strip
  end

end
