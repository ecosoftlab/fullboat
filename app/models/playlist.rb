class Playlist < ActiveRecord::Base
  acts_as_textiled :note
  
  belongs_to :user
  belongs_to :program
  
  validates_presence_of :user, :program
  validates_presence_of :start_time
  
  validate :validate_start_time_before_end_time
  
private

  def validate_start_time_before_end_time
    if self[:end_time] && self[:start_time] > self[:end_time]
      errors.add "Start time must be before end time"
    end
  end
end
