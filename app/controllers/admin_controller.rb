class AdminController < ApplicationController
  before_filter :login_required
  
  def schedule
    render :layout => 'layouts/schedule'
  end
  
  def music
    render :action => 'admin/sections/music', :layout => 'layouts/music'
  end
  
  def programming
    render :action => 'admin/sections/programming', :layout => 'layouts/programming'
  end
  
  def exec
    render :action => 'admin/sections/exec'
  end

end
