class Promo < ActiveRecord::Base
  acts_as_textiled :body

  validates_presence_of :code
  validates_numericality_of :length, :allow_nil => true
  
  def to_s
    self.code
  end
end
