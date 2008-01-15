class Play < ActiveRecord::Base
  belongs_to :playlist
  belongs_to :playable,
             :polymorphic => true
             
  validates_presence_of :playlist, :playable
  validates_presence_of :name
end
