class Contributor < ActiveRecord::Base

  validates_length_of       :email,     :within => 3..100
  validates_length_of       :phone,     :within => 6..12

  has_and_belongs_to_many :programs
  
  composed_of :name, 
              :class_name => "Name", 
              :mapping => [ # database    ruby 
                          [ :first_name,  :first    ], 
                          [ :last_name,   :last     ]]

  def to_s
    self.name.to_s
  end
  
  def email_address_with_name
    "\"#{self.name.to_s}\" <#{self.email}>"
  end

  def name=(fullname)
    name = fullname.split(/\s/)
    self[:last_name], self[:first_name] = name.pop, name.join(" ")
  end

  def self.find_by_name(name)
    p = Person.new(:name => name)
    find_by_first_name_and_last_name(p.name.first, p.name.last)
  end

end
