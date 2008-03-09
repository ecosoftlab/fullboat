class EventsController < ApplicationController
  
  layout 'calendar'
  
  # GET /events
  # GET /events.xml
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
      format.html # index.rhtml
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

  # GET /events/1
  # GET /events/1.xml
  def show
    @event = Event.find(params[:id])

    respond_to do |format|
      format.html # show.rhtml
      format.xml  { render :xml => @event.to_xml }
    end
  end

  # GET /events/new
  def new
    @event = Event.new
  end

  # GET /events/1;edit
  def edit
    @event = Event.find(params[:id])
  end

  # POST /events
  # POST /events.xml
  def create
    @event = Event.new(params[:event])
    @event.save!

    respond_to do |format|
      flash[:notice] = 'Event was successfully created.'
      format.html { redirect_to event_url(@event) }
      format.xml  { head :created, :location => event_url(@event) }
      format.js   { render :template => 'events/success' }
    end
    
  rescue ActiveRecord::RecordInvalid
    respond_to do |format|
        format.html { render :action => :new }
        format.xml  { render :xml => @event.errors.to_xml }
        format.js   { render :template => 'events/error' }
    end
  end

  # PUT /events/1
  # PUT /events/1.xml
  def update
    @event = Event.find(params[:id])

    respond_to do |format|
      if @event.update_attributes(params[:event])
        flash[:notice] = "Event '#{@event}' was successfully updated."
        format.html { redirect_to event_url(@event) }
        format.xml  { head :ok }
        format.js   { render :template => 'events/success' }
      else
        format.html { render :action => :edit }
        format.xml  { render :xml => @event.errors.to_xml }
        format.js   { render :template => 'events/error' }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.xml
  def destroy
    @event = Event.find(params[:id])
    @event.destroy

    respond_to do |format|
      flash[:notice] = "Event '#{@event}' was destroyed."
      format.html { redirect_to events_url }
      format.xml  { head :ok }
      format.js   # destroy.rjs
    end
  end
  
  # GET /events;manage
  def manage
    @events = Event.find(:all)
  end
end
