class AdminController < ApplicationController
  before_filter :login_required
  
  def music
    render :action => 'admin/sections/music', :layout => 'layouts/music'
  end
  
  def production
    render :action => 'admin/sections/production'
  end
  
  def exec
    render :action => 'admin/sections/exec'
  end
end
