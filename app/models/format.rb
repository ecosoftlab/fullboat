class Format < ActiveRecord::Base
  has_many :albums
  
  has_attached_file :icon, :styles => { :large => "128x128", :default => '48x48', :tiny => '24x24' }
  
  validates_presence_of   :name
  validates_uniqueness_of :name
  
  def to_s
    self.name
  end
end
