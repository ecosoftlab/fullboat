class Album < ActiveRecord::Base  
  named_scope :recent, :conditions => {:status => ['TBR', 'BIN', 'N&WC'], 
                                    :created_at => 2.weeks.ago..Time.now },
                       :order => 'created_at DESC'
  
  
  has_attached_file :cover, :styles => { :large => "300x300>", :jewelcase => "126x126#", :tiny => '24x24' },
                            :default_style => :jewelcase,
                            :default_url => "/images/missing-cover.gif"  
  
  acts_as_state_machine :initial => "TBR", :column => 'status'
  
  # TODO Add notifications
  state :tbr, :value => "TBR"
  state :bin, :value => "BIN"
  state :oob, :value => "OOB"  
  state :nib, :value => "NIB"
  state :nwc, :value => "N&WC"
  state :missing, :value => "Missing"
  state :library, :value => "Library"
  
  event :review do
    transitions :from => "TBR", :to => "BIN"
  end
  
  event :report_missing do
    transitions :from => ["TBR", "BIN", "OOB", "NIB", "N&WC", "Library"], :to => "Missing"
  end
  
  event :shelve do
    transitions :from => "Missing", :to => "Library"
    transitions :from => "BIN", :to => "OOB"
    transitions :from => "TBR", :to => "NIB"
  end
  
  
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
  
  searchify :name, :artist => [:name]
  
  serialize  :tracks

  validates_presence_of     :artist, 
                            :unless => lambda { |album| album.is_compilation?}
  
  validates_presence_of     :name
  validates_uniqueness_of   :name, :scope => :artist_id, :unless => lambda { |album| album.artist.nil? }
                            
  before_validation_on_create :initialize_sort_name
  before_validation_on_create :check_for_compilation
  
  def to_param
    return "#{self.id}-#{self.name.gsub(/\W/, '')}"
  end

  def to_s
    self.name
  end
  
  def description
    "%s\nArtist: %s\nReleased on: %s\nLabel: %s\n\n%s" % \
      [self.name, self.artist || "N/A", self.released_on || "Unknown", self.label || "Unknown", self.tracks]
  end
  
  def self.most_played(options = {})    
    self.find_by_sql(["SELECT COUNT(plays.id) AS count, 
	    	                albums.*, 
		                    artists.id as artist_id, artists.name as artist_name
		                    FROM plays INNER JOIN albums
		                    	ON plays.playable_id = albums.id && plays.playable_type = 'Album'
		                    INNER JOIN artists
		                    	ON albums.artist_id = artists.id
		                    WHERE (plays.created_at BETWEEN ? AND ?)
		                    GROUP BY plays.playable_id
		                    ORDER BY count DESC
		                    LIMIT ?",
		                    options[:start_date] || Time.now - 1.week,
		                    options[:end_date]   || Time.now,
		                    options[:limit] || 10
		                ])
  end
  
protected

  def initialize_sort_name
    self[:sort_name] ||= self[:name].strip.gsub(/^([^a-zA-z\d]*|(the|a))\s+/i, "") if self[:name]
  end
  
  def check_for_compilation
    #self[:is_compilation] ||= ! self.artist.valid? rescue false
  end
end
