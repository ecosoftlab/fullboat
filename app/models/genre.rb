class Genre < ActiveRecord::Base
  has_many :albums

  validates_presence_of   :name
  validates_uniqueness_of :name
  validates_length_of     :name, :maximum => 50

  def to_s
    self.name
  end

end
