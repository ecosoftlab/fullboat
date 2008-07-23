class Artist < ActiveRecord::Base
  acts_as_textiled :description
  
  @@per_page = 50
  cattr_reader :per_page
  
  has_many :albums
  has_many :genres, :through => :albums, :uniq => true

  has_many :comments, 
           :as => :commentable, 
           :dependent => :destroy
  
  searchify :name, :description

  validates_presence_of   :name, :sort_name
  validates_uniqueness_of :name
  
  before_validation_on_create :initialize_sort_name
  
  def to_param
    return "#{self.id}-#{self.sort_name.gsub(/\W/, '')}"
  end
  
  def to_s
    self.name
  end
  
  # def self.search(name)
  #   Artist.find(:all, :conditions => ['name LIKE ?', name.concat("%")], :limit => 20)
  # end
  
  def genre
    self.genres.first
  end
  
private

  def initialize_sort_name
    self[:sort_name] ||= self[:name].strip.gsub(/^([^a-zA-z\d]*|(the))\s+/i, "") if self[:name]
  end
end
