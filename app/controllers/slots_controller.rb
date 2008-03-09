class SlotsController < ApplicationController
  
  # Programming Section
  layout 'programming'
    
  # GET /slots
  # GET /slots.xml
  def index
    @slots = Slot.find(:all)

    options = { :feed => { :title       => "Slots",
                           :description => "",
                           :language    => "en-us" },
                :item => { :title       => :title,
                           :description => :description,
                           :pub_date    => :created_at }
              }

    respond_to do |format|
      format.html # index.rhtml
      format.xml  { render :xml => @slots.to_xml }
      format.rss  { render_rss_feed_for @slots, 
                      options.update({:link => formatted_slots_url(:rss)}) 
                  }
      format.atom { render_atom_feed_for @slots, 
                      options.update({:link => formatted_slots_url(:atom)}) 
                  }
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
      format.js   { render :template => 'slots/success' }
    end
    
  rescue ActiveRecord::RecordInvalid
    respond_to do |format|
        format.html { render :action => :new }
        format.xml  { render :xml => @slot.errors.to_xml }
        format.js   { render :template => 'slots/error' }
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
        format.js   { render :template => 'slots/success' }
      else
        format.html { render :action => :edit }
        format.xml  { render :xml => @slot.errors.to_xml }
        format.js   { render :template => 'slots/error' }
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
  
  # GET /slots;manage
  def manage
    @slots = Slot.find(:all)
  end
end
