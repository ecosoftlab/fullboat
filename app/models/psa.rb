class PSA < ActiveRecord::Base
  acts_as_textiled :body
  
  validates_presence_of     :code
  validates_numericality_of :duration, :allow_nil => true
    
  def to_s
    self.code
  end
  
  def expires?
    !! self[:expires_on]
  end
end