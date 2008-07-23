class Playlist < ActiveRecord::Base
  acts_as_textiled :note
  
  belongs_to :user
  belongs_to :program
  
  has_many   :plays
  
  validates_presence_of :user
  validates_presence_of :starts_at, :ends_at
  
  validate :validate_starts_at_before_ends_at
  validate :validate_duration_less_than_24_hours
  
  def to_s
    self.starts_at.to_ordinalized_s(:mdy)
  end
  
  def description
    self.plays.collect{|play| play.to_s}.join("\n")
  end
  
private

  def validate_starts_at_before_ends_at
    if self[:ends_at] && self[:starts_at] > self[:ends_at]
      errors.add "Start time must be before end time"
    end
  end
  
  def validate_duration_less_than_24_hours
    if self[:ends_at] - self[:starts_at] > 24.hours
      errors.add "Playlist cannot exceed 24 hours in duration"
    end
  end
end
