class Schedule < ActiveRecord::Base
  
  def Schedule.semesters
    ['fall','spring','summer']
  end
  
  validates_inclusion_of :semester, :in=>Schedule.semesters, :message => "Semester must be one of 'fall', 'spring', 'summer'."
  validates_inclusion_of :year, :in=>2000..2100, :message=>"Year must be a valid 4 digit year."

end
