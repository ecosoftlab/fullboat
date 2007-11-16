class Role < ActiveRecord::Base
  has_and_belongs_to_many :users
  
  validates_presence_of   :title
  validates_uniqueness_of :title
  validates_format_of     :title,
                          :with => /[^@\.\s]/
                          
  before_validation       :format_title
  
  def to_s
    self.title
  end

private

  def format_title
    self[:title] = self[:title].gsub(/\s+/, "_").downcase if self[:title]
  end
end
