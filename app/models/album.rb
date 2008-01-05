class Album < ActiveRecord::Base
  @@status_values = ["TBR", "Bin", "OOB", "NIB", "N&WC", "Missing", "Library"]
  cattr_reader
  
  acts_as_taggable
  
  has_many :comments, 
           :as => :commentable, 
           :dependent => :destroy
           
  has_one  :review,   
           :dependent => :destroy

  belongs_to :artist
  belongs_to :label
  belongs_to :promoter
  belongs_to :genre
  belongs_to :format

  validates_presence_of     :artist, :unless => Proc.new{ |album| album.is_compilation?}
  validates_inclusion_of    :status,
                            :within => @@status_values
                            
  validates_numericality_of :year, :allow_nil => true

  def to_param
    return "#{self.id}-#{self.name.gsub(/\W/, '')}"
  end

  def to_s
    self.name
  end

end
