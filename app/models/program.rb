class Program < ActiveRecord::Base
  
  has_and_belongs_to_many :tags
  has_and_belongs_to_many :schedules
  has_and_belongs_to_many :users
  has_and_belongs_to_many :contributors  
  has_and_belongs_to_many :underwriting_contracts
  
  has_one :promo
  
  def to_s
    self.name.to_s
  end
  
  def self.hours
    (0..23).to_a
  end
  
  def self.minutes
    (0..59).to_a
  end

  def self.categories
    [:music,:public_affairs]
  end
  
  def self.days
    [:sunday,:monday,:tuesday,:wednesday,:thursday,:friday,:saturday]
  end

end
