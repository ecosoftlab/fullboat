class Play < ActiveRecord::Base
  acts_as_list :scope => :playlist_id
  
  belongs_to :playlist
  belongs_to :playable,
             :polymorphic => true
             
  before_validation :initialize_name
             
  validates_presence_of :playlist, :playable
  validates_presence_of :name
    
  def to_s
    case self.playable
    when Album
      "'%s' - %s (%s)" % [self.name, self.playable.artist, self.playable]
    else
      self.name
    end
  end
  
  def duration
    self.playable.duration rescue nil
  end
  
private

  def initialize_name
    self.name ||= self.playable.to_s
  end

end
