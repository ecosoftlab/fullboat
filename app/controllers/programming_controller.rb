class ProgrammingController < ApplicationController
  layout 'programming'
  
  def index
    @schedule  = Schedule.current
  end
end
