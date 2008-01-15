class Address
	attr_reader :street, :city, :state, :zip

	def initialize(street, city, state, zip) 
		@street = street
		@city   = city
		@state  = state  
		@zip    = zip
	end
	
	def to_s(options = {})
	  [@street, @city && @state && @zip ? "%s, %s %s" % [@city, @state, @zip] : nil].compact.join("\n")
  end
end