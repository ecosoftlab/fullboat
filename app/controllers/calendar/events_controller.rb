class Calendar::EventsController < CalendarController
  
  # GET /events
  # GET /events.xml
  def index
    redirect_to calendar_root_url
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
      format.js   { render :template => 'calendar/events/success' }
    end
    
  rescue ActiveRecord::RecordInvalid
    respond_to do |format|
        format.html { render :action => :new }
        format.xml  { render :xml => @event.errors.to_xml }
        format.js   { render :template => 'calendar/events/error' }
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
        format.js   { render :template => 'calendar/events/success' }
      else
        format.html { render :action => :edit }
        format.xml  { render :xml => @event.errors.to_xml }
        format.js   { render :template => 'calendar/events/error' }
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
end
