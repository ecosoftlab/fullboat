class Event < ActiveRecord::Base
  acts_as_textiled :description
  
  def to_s
    self.name
  end
end
