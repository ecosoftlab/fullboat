class Play < ActiveRecord::Base
  belongs_to :playlist
  belongs_to :playable,
             :polymorphic => true
             
  validates_presence_of :playlist, :playable
  validates_presence_of :name
  
  
  def to_s
    case klass = self.playable.class.to_s
    when "Album"
      "%s - %s (%s)" % [self.name, self.playable.artist, self.playable]
    else
      self.name
    end
  end
end
