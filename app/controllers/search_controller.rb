class SearchController < ApplicationController
  def index
  end
  
  # TODO Refactor?
  def query
    if params[:q].blank?
      render :action => :index 
    else
      # Try to do exact search by name and instantly link to that
      @initial_results = search_results(:name => params[:q], :per_page => 3)
      @initial_results.flatten!
      
      case @initial_results.length
      when 0
        flash[:notice] = "Sorry, no results were found for '#{params[:q]}'"
        render :action => :index # no results
      when 1
        redirect_to @initial_results.first
      else
        @results = search_results(:all => params[:q])
        @artists, @albums, @programs, @users = @results
        @results.flatten!
        
        case @results.length
        when 0
          # This shouldn't happen
        when 1
          redirect_to @results.first
        else
          render :action => :results
        end
      end
    end
  end
  
  def remote_live_search
    @results = search_results(:all => params[:q], :per_page => 5).flatten
    render :action => "search/remote_live_search", :layout => false if @results.any?
  end
  
protected

  def search_results(options)
    [Artist, Album, Program, User].collect{|m| m.send(:search, options)}    
  end
end
