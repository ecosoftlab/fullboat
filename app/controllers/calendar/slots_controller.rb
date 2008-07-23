class Calendar::SlotsController < ApplicationController
  
  # Programming Section
  layout 'programming'
    
  # GET /slots
  # GET /slots.xml
  def index
    @schedule = Schedule.find(params[:schedule_id])
    
    if @schedule
      respond_to do |format|
        format.html { redirect_to schedule_url(@schedule) }
        format.xml  { render :xml => @schedule.slots.to_xml }
      end
    else
      respond_to do |format|
        format.html { redirect_to calendar_root_url }
      end
    end
  end

  # GET /slots/1
  # GET /slots/1.xml
  def show
    @slot = Slot.find(params[:id])
    @schedule = @slot.schedule

    respond_to do |format|
      format.html # show.rhtml
      format.xml  { render :xml => @slot.to_xml }
    end
  end

  # GET /slots/new
  def new
    @slot = Slot.new
    @schedule = Schedule.find(params[:schedule_id])
  end

  # GET /slots/1;edit
  def edit
    @slot = Slot.find(params[:id])
  end

  # POST /slots
  # POST /slots.xml
  def create
    @slot = Slot.new(params[:slot])
    @slot.save!

    respond_to do |format|
      flash[:notice] = 'Slot was successfully created.'
      format.html { redirect_to slot_url(@slot) }
      format.xml  { head :created, :location => slot_url(@slot) }
      format.js   { render :template => 'calendar/slots/success' }
    end
    
  rescue ActiveRecord::RecordInvalid
    respond_to do |format|
        format.html { render :action => :new }
        format.xml  { render :xml => @slot.errors.to_xml }
        format.js   { render :template => 'calendar/slots/error' }
    end
  end

  # PUT /slots/1
  # PUT /slots/1.xml
  def update
    @slot = Slot.find(params[:id])

    respond_to do |format|
      if @slot.update_attributes(params[:slot])
        flash[:notice] = "Slot '#{@slot}' was successfully updated."
        format.html { redirect_to slot_url(@slot) }
        format.xml  { head :ok }
        format.js   { render :template => 'calendar/slots/success' }
      else
        format.html { render :action => :edit }
        format.xml  { render :xml => @slot.errors.to_xml }
        format.js   { render :template => 'calendar/slots/error' }
      end
    end
  end

  # DELETE /slots/1
  # DELETE /slots/1.xml
  def destroy
    @slot = Slot.find(params[:id])
    @slot.destroy

    respond_to do |format|
      flash[:notice] = "Slot '#{@slot}' was destroyed."
      format.html { redirect_to slots_url }
      format.xml  { head :ok }
      format.js   # destroy.rjs
    end
  end
end
