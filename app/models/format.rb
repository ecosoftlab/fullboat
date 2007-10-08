class Format < ActiveRecord::Base

  has_many :albums

  validates_presence_of :name
  validates_length_of :name, :within => 1..20
  validates_uniqueness_of :name

end
