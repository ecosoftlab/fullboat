class Programming::ProgramsController < ApplicationController
  before_filter :login_required
  
  # Programming Section
  layout 'programming'
  
  # GET /programs
  # GET /programs.xml
  def index
    @schedules = Schedule.find(:all, :include => :programs)
    @schedule  = Schedule.find(params[:schedule_id])
    @programs  = @schedule.programs
  rescue ActiveRecord::RecordNotFound
    @programs = Program.find(:all)
  ensure
    respond_to do |format|
      format.html # index.rhtml
      format.xml  { render :xml => @programs.to_xml }
    end
  end

  # GET /programs/1
  # GET /programs/1.xml
  def show
    @program = Program.find(params[:id])

    respond_to do |format|
      format.html # show.rhtml
      format.xml  { render :xml => @program.to_xml }
    end
  end

  # GET /programs/new
  def new
    @program = Program.new
  end

  # GET /programs/1;edit
  def edit
    @program = Program.find(params[:id])
  end

  # POST /programs
  # POST /programs.xml
  def create
    @program = Program.new(params[:program])
    @program.save!

    respond_to do |format|
      flash[:notice] = 'Program was successfully created.'
      format.html { redirect_to program_url(@program) }
      format.xml  { head :created, :location => program_url(@program) }
      format.js   { render :template => 'programs/success' }
    end
    
  rescue ActiveRecord::RecordInvalid
    respond_to do |format|
        format.html { render :action => :new }
        format.xml  { render :xml => @program.errors.to_xml }
        format.js   { render :template => 'programs/error' }
    end
  end

  # PUT /programs/1
  # PUT /programs/1.xml
  def update
    @program = Program.find(params[:id])

    respond_to do |format|
      if @program.update_attributes(params[:program])
        flash[:notice] = "Program '#{@program}' was successfully updated."
        format.html { redirect_to program_url(@program) }
        format.xml  { head :ok }
        format.js   { render :template => 'programs/success' }
      else
        format.html { render :action => :edit }
        format.xml  { render :xml => @program.errors.to_xml }
        format.js   { render :template => 'programs/error' }
      end
    end
  end

  # DELETE /programs/1
  # DELETE /programs/1.xml
  def destroy
    @program = Program.find(params[:id])
    @program.destroy

    respond_to do |format|
      flash[:notice] = "Program '#{@program}' was destroyed."
      format.html { redirect_to programs_url }
      format.xml  { head :ok }
      format.js   # destroy.rjs
    end
  end
end
