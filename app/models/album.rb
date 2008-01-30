class Album < ActiveRecord::Base
  acts_as_taggable

  @@status_values = ["TBR", "Bin", "OOB", "NIB", "N&WC", "Missing", "Library"]
  cattr_reader :status_values
  
  @@per_page = 50
  cattr_reader :per_page
    
  has_many :comments, 
           :as => :commentable, 
           :dependent => :destroy
  
  has_many :plays,
           :as => :playable
          
  has_one  :review,   
           :dependent => :destroy

  belongs_to :artist
  belongs_to :label
  belongs_to :genre
  
  serialize  :tracks

  validates_presence_of     :artist, 
                            :unless => lambda { |album| album.is_compilation?}
  
  validates_uniqueness_of   :name, :scope => :artist_id, :unless => lambda { |album| album.artist.nil? }
                           
  validates_inclusion_of    :status,
                            :within    => @@status_values,
                            :allow_nil => true
                            
  def to_param
    return "#{self.id}-#{self.name.gsub(/\W/, '')}"
  end

  def to_s
    self.name
  end
  
  def change_status(status, options = {})
    self.comments << Comment.create(:body => "Status was changed from %s on %s" % [self[:status], Date.today])
    self.update_attribute(:status, status)
  end
end
