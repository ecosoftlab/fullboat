class StaphController < ApplicationController
  layout 'staph'

  def index
    @users = User.paginate(:all, :page => params[:page], :order => "last_name ASC")
  end
end
