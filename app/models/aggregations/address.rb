class Address
	attr_reader :street, :extended, :city, :state, :zip

	def initialize(street, extended, city, state, zip) 
		@street   = street
		@extended = extended
		@city     = city
		@state    = state  
		@zip      = zip
	end
	
	def to_s(options = {})
	  [@street, @extended, @city && @state && @zip ? "%s, %s %s" % [@city, @state, @zip] : nil].compact.join("\n")
  end
end