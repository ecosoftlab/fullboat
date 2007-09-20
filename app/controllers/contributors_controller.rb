class ContributorsController < ApplicationController
  before_filter :login_required
  # GET /contributors
  # GET /contributors.xml
  def index
    @contributors = Contributor.find(:all)

    options = { :feed => { :title       => "Contributors",
                           :description => "",
                           :language    => "en-us" },
                :item => { :title       => :title,
                           :description => :description,
                           :pub_date    => :created_at }
              }

    respond_to do |format|
      format.html # index.rhtml
      format.xml  { render :xml => @contributors.to_xml }
      format.rss  { render_rss_feed_for @contributors, 
                      options.update({:link => formatted_contributors_url(:rss)}) 
                  }
      format.atom { render_atom_feed_for @contributors, 
                      options.update({:link => formatted_contributors_url(:atom)}) 
                  }
    end
  end

  # GET /contributors/1
  # GET /contributors/1.xml
  def show
    @contributor = Contributor.find(params[:id])

    respond_to do |format|
      format.html # show.rhtml
      format.xml  { render :xml => @contributor.to_xml }
    end
  end

  # GET /contributors/new
  def new
    @contributor = Contributor.new
  end

  # GET /contributors/1;edit
  def edit
    @contributor = Contributor.find(params[:id])
  end

  # POST /contributors
  # POST /contributors.xml
  def create
    @contributor = Contributor.new(params[:contributor])
    @contributor.save!

    respond_to do |format|
      flash[:notice] = 'Contributor was successfully created.'
      format.html { redirect_to contributors_url }
      format.xml  { head :created, :location => contributor_url(@contributor) }
      format.js   { render :action => :success }
    end
    
  rescue ActiveRecord::RecordInvalid
    respond_to do |format|
        format.html { render :action => :new }
        format.xml  { render :xml => @contributor.errors.to_xml }
        format.js   { render :template => :error }
    end
  end

  # PUT /contributors/1
  # PUT /contributors/1.xml
  def update
    @contributor = Contributor.find(params[:id])

    respond_to do |format|
      if @contributor.update_attributes(params[:contributor])
        flash[:notice] = "Contributor '#{@contributor}' was successfully updated."
        format.html { redirect_to contributors_url }
      else
        format.html { render :action => :edit }
        format.xml  { render :xml => @contributor.errors.to_xml }
        format.js   { render :template => :error }
      end
    end
  end

  # DELETE /contributors/1
  # DELETE /contributors/1.xml
  def destroy
    @contributor = Contributor.find(params[:id])
    @contributor.destroy

    respond_to do |format|
      # flash[:notice] = "Contributor '#{@contributor}' was destroyed."
      format.html { redirect_to contributors_url }
      format.xml  { head :ok }
      format.js   # destroy.rjs
    end
  end
  
  # GET /contributors;manage
  def manage
    @contributors = Contributor.find(:all)
  end
end
