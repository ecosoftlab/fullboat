class Review < ActiveRecord::Base

  belongs_to :album
  belongs_to :user

  validates_presence_of :album_id
  validates_presence_of :user_id

  validates_presence_of :body

end
