class AdminController < ApplicationController
  before_filter :login_required
  
  def schedule
    render :layout => 'layouts/schedule'
  end
  
  def music
    @plays = Play.find(:all, 
                       :conditions => ["playable_type = ? AND created_at BETWEEN ? AND ?", 
                                        "Album", Time.now.beginning_of_week, Time.now])
    @plays.collect!{|p| p.playable}
    @albums  = @plays.uniq.sort_by{|p| @plays.grep(p).length}
    @reviews = Review.find(:all, :order => "created_at DESC", :limit => 5)
    
    render :action => 'admin/sections/music', :layout => 'layouts/music'
  end
  
  def programming
    @schedule  = Schedule.current
    
    render :action => 'admin/sections/programming', :layout => 'layouts/programming'
  end
  
  def exec
    render :action => 'admin/sections/exec'
  end

end
