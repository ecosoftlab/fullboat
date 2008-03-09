class Comment < ActiveRecord::Base
  acts_as_textiled :body

  belongs_to :commentable, :polymorphic => true
  belongs_to :user

  has_one :play, 
          :as => :playable,
          :dependent => :destroy

  validates_presence_of :commentable
  validates_presence_of :body

  def to_s
    self.body_source
  end

end
