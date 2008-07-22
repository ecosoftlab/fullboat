class Slot < ActiveRecord::Base
  belongs_to :schedule
  belongs_to :program
  
  before_validation :numeralize_day
  
  validates_presence_of     :schedule, :program
  validates_presence_of     :day, :start_time, :end_time
  validates_numericality_of :day
  validates_inclusion_of    :day, :within => Date::DAYS.values
  
  validates_uniqueness_of   :program_id, :scope => :schedule_id
  
  validate :validate_start_time_before_end_time
  validate :validate_avaibility_of_timespan
  
  def to_param
    "#{self.id}-#{self.to_s.gsub(/\s/, '-').gsub(/\W/, '')}"
  end
  
  def to_s
    [self.weekday, [self.start_time, self.end_time].collect{|t| t.to_ordinalized_s(:time_only)}.join(' - '), self.schedule].join(" ")
  end
  
  def duration
    ((self.end_time - self.start_time) / 3600).to_i
  end
  
  def weekday
    Date::DAYS.invert[self.day].capitalize
  end
  
protected

  def numeralize_day
    if Date::DAYS.keys.include? self[:day]
      self[:day] = Date::DAYS[self[:day]]
    end
  end

  def validate_start_time_before_end_time
    if (self[:start_time] && self[:end_time]) && self[:start_time] > self[:end_time]
      errors.add "Start time must be before end time"
    end
  end
  
  def validate_avaibility_of_timespan
    conflict = Slot.find(:first, :conditions => ["schedule_id = ? AND day = ? AND start_time = ?", 
                                                  self[:schedule_id], self[:day], self[:start_time]])
  
    errors.add "Time span not available (already taken by #{conflict})" if conflict
  end
end
