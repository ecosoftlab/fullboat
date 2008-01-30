class Promo < ActiveRecord::Base
  acts_as_textiled :body

  belongs_to :promotable, :polymorphic => true

  validates_presence_of     :code
  validates_numericality_of :duration, :allow_nil => true
  
  def to_s
    self.code
  end
end
