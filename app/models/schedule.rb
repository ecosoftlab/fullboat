class Schedule < ActiveRecord::Base
  acts_as_textiled :description
  
  has_many :slots, :dependent => :destroy
  has_many :programs, :through => :slots
  
  validates_presence_of :name
  validates_presence_of :starts_at, :ends_at
  
  validate :validate_start_time_before_end_time
  
  def to_param
    return "#{self.id}-#{self.name.gsub(/\W/, '')}"
  end
  
  def to_s
    self.name
  end
  
  # def is_available?(day, time)
  #   Slot.find(:all, :conditions => ["schedule_id = :id AND :start_time"])
  # end
  
  def slot_at(day, time)
    Slot.find(:first, :conditions => ["schedule_id = :id AND day = :day AND :time BETWEEN start_time AND end_time", 
                                       {:id => self.id, :day => day, :time => time}])
  end
  
  def slot_starting_at(day, time)
    Slot.find(:first, :conditions => ["schedule_id = :id AND day = :day AND :time = start_time", 
                                       {:id => self.id, :day => day, :time => time}])
  end
  
  def slot_ending_at(day, time)
    Slot.find(:first, :conditions => ["schedule_id = :id AND day = :day AND :time = end_time", 
                                       {:id => self.id, :day => day, :time => time}])
  end
  
protected

  def validate_start_time_before_end_time
    if (self[:starts_at] && self[:ends_at]) && self[:starts_at] > self[:ends_at]
      errors.add "Start time must be before end time"
    end
  end
end
