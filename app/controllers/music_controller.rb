class MusicController < ApplicationController
  layout 'music'
  
  def index
    @plays   = Play.find(:all, 
                         :conditions => ["playable_type = ? AND created_at BETWEEN ? AND ?", 
                                        "Album", Time.now.beginning_of_week, Time.now],
                         :order => "created_at DESC")
    @albums  = @plays.collect{|p| p.playable}.sort_by{|p| @plays.collect{|p| p.playable}.grep(p).length}
    @reviews = Review.find(:all, :order => "created_at DESC", :limit => 5)
  end
end
