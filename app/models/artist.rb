class Artist < ActiveRecord::Base

  has_many :albums

  validates_uniqueness_of :name
  validates_presence_of :name
  validates_length_of :name, :within => 1..100

  validates_presence_of :sort_name
  validates_length_of :sort_name, :within => 1..100


end
