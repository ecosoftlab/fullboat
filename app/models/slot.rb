class Slot < ActiveRecord::Base
  belongs_to :schedule
  belongs_to :schedulable, :polymorphic => true
  
  validates_presence_of     :day, :start_time, :end_time
  validates_numericality_of :day
  validates_inclusion_of    :day, :within => (0..6)
  
  validate :validate_start_time_before_end_time
  validate :validate_avaibility_of_timespan
  
  def to_s
    self.schedulable.to_s
  end
  
  def duration
    ((self.end_time - self.start_time) / 3600).to_i
  end
  
protected
  
  def validate_start_time_before_end_time
    if self[:start_time] > self[:end_time]
      errors.add "Start time must be before end time"
    end
  end
  
  def validate_avaibility_of_timespan
    if Slot.find(:all, :conditions => ["start_time BETWEEN ? AND ?", self[:start_time], self[:end_time]]).any?
      errors.add "Time span not available"
    end
  end
end
