class Name
  attr_reader :first, :last
  
  def initialize(firstname, lastname)
    @first = firstname
    @last  = lastname
  end
  
  def reverse
    [@last, @first].join(', ').squeeze(' ')
  end
  
  def to_s
    [@first, @last].join(' ').squeeze(' ')
  end
  
  def <=>(name)
    self.reverse.to_s <=> name.reverse.to_s
  end
  
  def method_missing(method_id, *args)
    self.to_s.send(method_id, *args)
  end
end