class Review < ActiveRecord::Base
  acts_as_textiled :body

  belongs_to :album
  belongs_to :user
  
  searchify :body, :user => [:first_name, :last_name, :dj_name, :login]

  validates_presence_of :album
  validates_presence_of :user
  validates_presence_of :body
  
  after_create :fire_review_event_for_album

  def to_s
    "%s / %s" % [self.album, self.album.artist]
  end
 
protected

  def fire_review_event_for_album
    self.album.review!
  end
end
