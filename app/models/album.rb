class Album < ActiveRecord::Base
  acts_as_taggable
  has_many :comments, :as => :commentable

  belongs_to :artist
  belongs_to :label
  belongs_to :promoter
  belongs_to :genre
  belongs_to :format

  validates_presence_of :artist, :if => Proc.new{ |album| album.is_compilation == false}
  validates_presence_of :label

  validates_presence_of :genre
  validates_presence_of :format

  validates_presence_of :year
  validates_inclusion_of :year, :in => 1000..3000

  validates_presence_of :status
  validates_columns :status

  validates_presence_of :status_changed_on

  validates_inclusion_of :is_compilation, :in => [true,false]

  def create_comment
    
  end
  
end
