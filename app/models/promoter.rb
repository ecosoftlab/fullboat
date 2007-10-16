class Promoter < ActiveRecord::Base

  has_many :albums
  has_many :labels, :through => :albums
  has_many :artists, :through => :albums

  validates_presence_of :name
  validates_length_of :name, :within => 1..100
  validates_uniqueness_of :name

  validates_format_of :email, :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i, :on => :create,:if => :email?, :allow_nil => true

end
