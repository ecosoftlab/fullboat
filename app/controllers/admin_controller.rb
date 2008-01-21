class AdminController < ApplicationController
  before_filter :login_required
  
  def schedule
    render :layout => 'layouts/schedule'
  end
  
  def music
    render :action => 'admin/sections/music', :layout => 'layouts/music'
  end
  
  def production
    render :action => 'admin/sections/production', :layout => 'layouts/production'
  end
  
  def exec
    render :action => 'admin/sections/exec'
  end
end
