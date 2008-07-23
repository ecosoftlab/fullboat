class SectionsController < ApplicationController
  before_filter :login_required

  def index
    @section = "Welcome"
  end

  def music
    @plays   = Play.find(:all, 
                         :conditions => ["playable_type = ? AND created_at BETWEEN ? AND ?", 
                                        "Album", Time.now.beginning_of_week, Time.now],
                         :order => "created_at DESC")
    @albums  = @plays.collect{|p| p.playable}.sort_by{|p| @plays.collect{|p| p.playable}.grep(p).length}
    @reviews = Review.find(:all, :order => "created_at DESC", :limit => 5)
    
    render :action => 'sections/music', :layout => 'layouts/music'
  end
  
  def programming
    @schedule  = Schedule.current
    
    render :action => 'sections/programming', :layout => 'layouts/programming'
  end
  
  def calendar
    @events = Event.find(:all)
    if params[:year] && params[:month]
      @year = params[:year]
      @month = params[:month]
    end

    options = { :feed => { :title       => "Events",
                           :description => "",
                           :language    => "en-us" },
                :item => { :title       => :title,
                           :description => :description,
                           :pub_date    => :created_at }
              }

    respond_to do |format|
      format.html { render :action => 'sections/calendar', :layout => 'layouts/calendar'}
      format.xml  { render :xml => @events.to_xml }
      format.rss  { render_rss_feed_for @events, 
                      options.update({:link => formatted_events_url(:rss)}) 
                  }
      format.atom { render_atom_feed_for @events, 
                      options.update({:link => formatted_events_url(:atom)}) 
                  }
      format.ics  { cal = Icalendar::Calendar.new
                    @events.each do |e|
                      cal.event do
                        dtstart       e.starts_at
                        dtend         e.ends_at
                        summary       e.name
                        description   e.description_source
                        location      e.location
                      end
                    end
                    render :text => cal.to_ical
                  }
    end
  end
  
  def staph
    @users = User.paginate(:all, :page => params[:page], :order => "last_name ASC")
    
    render :action => 'sections/staph', :layout => 'layouts/staph'
  end

end
