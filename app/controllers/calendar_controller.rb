class CalendarController < ApplicationController
  layout 'calendar'
  
  def index
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
      format.html # index.html.erb
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
end
