class Album < ActiveRecord::Base  
  has_attached_file :cover, :styles => { :large => "300x300>", :jewelcase => "126x126#", :tiny => '24x24' },
                            :default_style => :jewelcase,
                            :default_url => "/images/missing-cover.gif"

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
  
  searchify :name, :released_on, :artist => [:name], :review => [:body]
  
  serialize  :tracks

  validates_presence_of     :artist, 
                            :unless => lambda { |album| album.is_compilation?}
  
  validates_presence_of     :name
  validates_uniqueness_of   :name, :scope => :artist_id, :unless => lambda { |album| album.artist.nil? }
                           
  validates_inclusion_of    :status,
                            :within    => @@status_values,
                            :allow_nil => true
                            
  before_validation_on_create :initialize_sort_name
  
  def to_param
    return "#{self.id}-#{self.name.gsub(/\W/, '')}"
  end

  def to_s
    self.name
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
  
  def change_status(status, options = {})
    self.comments << Comment.create(:body => "Status was changed from %s on %s" % [self[:status], Date.today])
    self.update_attribute(:status, status)
  end
  
protected

  def initialize_sort_name
    self[:sort_name] ||= self[:name].strip.gsub(/^([^a-zA-z\d]*|(the|a))\s+/i, "") if self[:name]
  end
end
