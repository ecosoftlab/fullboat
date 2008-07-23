class SectionsController < ApplicationController
  before_filter :login_required

  def index
    @section = "Welcome"
  end

  def music
    
  end
  
  def programming
 
  end
  
  def calendar
    
  end
  
  def staph
  end

end
