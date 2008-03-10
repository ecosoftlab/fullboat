class Review < ActiveRecord::Base
  acts_as_textiled :body

  belongs_to :album
  belongs_to :user

  validates_presence_of :album_id
  validates_presence_of :user_id

  validates_presence_of :body

  def to_s
    "%s by %s" % [self.album, self.user]
  end

end
