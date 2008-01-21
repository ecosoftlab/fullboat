class SchedulesController < ApplicationController
 
  # Production Section
  layout 'production' 
  
  # GET /schedules
  # GET /schedules.xml
  def index
    @schedules = Schedule.find(:all)

    options = { :feed => { :title       => "Schedules",
                           :description => "",
                           :language    => "en-us" },
                :item => { :title       => :title,
                           :description => :description,
                           :pub_date    => :created_at }
              }

    respond_to do |format|
      format.html # index.rhtml
      format.xml  { render :xml => @schedules.to_xml }
      format.rss  { render_rss_feed_for @schedules, 
                      options.update({:link => formatted_schedules_url(:rss)}) 
                  }
      format.atom { render_atom_feed_for @schedules, 
                      options.update({:link => formatted_schedules_url(:atom)}) 
                  }
    end
  end

  # GET /schedules/1
  # GET /schedules/1.xml
  def show
    @schedule = Schedule.find(params[:id])

    respond_to do |format|
      format.html # show.rhtml
      format.xml  { render :xml => @schedule.to_xml }
    end
  end

  # GET /schedules/new
  def new
    @schedule = Schedule.new
  end

  # GET /schedules/1;edit
  def edit
    @schedule = Schedule.find(params[:id])
  end

  # POST /schedules
  # POST /schedules.xml
  def create
    @schedule = Schedule.new(params[:schedule])
    @schedule.save!

    respond_to do |format|
      flash[:notice] = 'Schedule was successfully created.'
      format.html { redirect_to schedule_url(@schedule) }
      format.xml  { head :created, :location => schedule_url(@schedule) }
      format.js   { render :template => 'schedules/success' }
    end
    
  rescue ActiveRecord::RecordInvalid
    respond_to do |format|
        format.html { render :action => :new }
        format.xml  { render :xml => @schedule.errors.to_xml }
        format.js   { render :template => 'schedules/error' }
    end
  end

  # PUT /schedules/1
  # PUT /schedules/1.xml
  def update
    @schedule = Schedule.find(params[:id])

    respond_to do |format|
      if @schedule.update_attributes(params[:schedule])
        flash[:notice] = "Schedule '#{@schedule}' was successfully updated."
        format.html { redirect_to schedule_url(@schedule) }
        format.xml  { head :ok }
        format.js   { render :template => 'schedules/success' }
      else
        format.html { render :action => :edit }
        format.xml  { render :xml => @schedule.errors.to_xml }
        format.js   { render :template => 'schedules/error' }
      end
    end
  end

  # DELETE /schedules/1
  # DELETE /schedules/1.xml
  def destroy
    @schedule = Schedule.find(params[:id])
    @schedule.destroy

    respond_to do |format|
      flash[:notice] = "Schedule '#{@schedule}' was destroyed."
      format.html { redirect_to schedules_url }
      format.xml  { head :ok }
      format.js   # destroy.rjs
    end
  end
  
  # GET /schedules;manage
  def manage
    @schedules = Schedule.find(:all)
  end
end
