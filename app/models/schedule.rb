class Schedule < ActiveRecord::Base

  def Schedule.semesters
    [:fall,:spring,:summer]
  end
  
  has_and_belongs_to_many :programs
  
  validates_inclusion_of :semester, :in=>Schedule.semesters, :message => "Semester must be one of 'fall', 'spring', 'summer'."
  validates_inclusion_of :year, :in=>2000..2100, :message=>"Year must be a valid 4 digit year."

end
