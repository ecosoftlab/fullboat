class Label < ActiveRecord::Base
  acts_as_textiled :note
  
  has_many :albums
  has_many :artists,   :through => :albums
  has_many :promoters, :through => :albums
  has_many :genres,    :through => :albums

  composed_of :address, 
              :class_name => "Address", 
              :mapping => [ # database 	ruby 
    								    	[ :street,	  :street		], 
    								    	[ :extended,	:extended	],
    								    	[ :city,	    :city		  ], 
    								    	[ :state,	    :state		], 
    								    	[ :zip,	      :zip		  ]]

  before_validation :format_phone
  before_validation :format_fax

  validates_presence_of   :name
  validates_length_of     :name, :maximum => 100
  validates_uniqueness_of :name

  validates_format_of :email, 
                      :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i, 
                      :allow_nil => true

  def to_param
    return "#{self.id}-#{self.name.gsub(/\W/, '')}"
  end

  def to_s
    self.name
  end
  
private

  def format_phone
    self[:phone].gsub!(/\D/, '') if self[:phone]
  end
  
  def format_fax
    self[:fax].gsub!(/\D/, '') if self[:fax]
  end
end
