class LabelsController < ApplicationController
  before_filter :login_required

  # Music Section
  layout 'music'

  # GET /labels
  # GET /labels.xml
  def index
    @labels = Label.find(:all)

    options = { :feed => { :title       => "Labels",
                           :description => "",
                           :language    => "en-us" },
                :item => { :title       => :title,
                           :description => :description,
                           :pub_date    => :created_at }
              }

    respond_to do |format|
      format.html # index.rhtml
      format.xml  { render :xml => @labels.to_xml }
      format.rss  { render_rss_feed_for @labels,
                      options.update({:link => formatted_labels_url(:rss)})
                  }
      format.atom { render_atom_feed_for @labels,
                      options.update({:link => formatted_labels_url(:atom)})
                  }
    end
  end

  # GET /labels/1
  # GET /labels/1.xml
  def show
    @label = Label.find(params[:id])

    respond_to do |format|
      format.html # show.rhtml
      format.xml  { render :xml => @label.to_xml }
    end
  end

  # GET /labels/new
  def new
    @label = Label.new
  end

  # GET /labels/1;edit
  def edit
    @label = Label.find(params[:id])
  end

  # POST /labels
  # POST /labels.xml
  def create
    @label = Label.new(params[:label])
    @label.save!

    respond_to do |format|
      flash[:notice] = 'Label was successfully created.'
      format.html { redirect_to label_url(@label) }
      format.xml  { head :created, :location => label_url(@label) }
      format.js   { render :template => 'labels/success' }
    end

  rescue ActiveRecord::RecordInvalid
    respond_to do |format|
        format.html { render :action => :new }
        format.xml  { render :xml => @label.errors.to_xml }
        format.js   { render :template => 'labels/error' }
    end
  end

  # PUT /labels/1
  # PUT /labels/1.xml
  def update
    @label = Label.find(params[:id])

    respond_to do |format|
      if @label.update_attributes(params[:label])
        flash[:notice] = "Label '#{@label}' was successfully updated."
        format.html { redirect_to label_url(@label) }
        format.xml  { head :ok }
        format.js   { render :template => 'labels/success' }
      else
        format.html { render :action => :edit }
        format.xml  { render :xml => @label.errors.to_xml }
        format.js   { render :template => 'labels/error' }
      end
    end
  end

  # DELETE /labels/1
  # DELETE /labels/1.xml
  def destroy
    @label = Label.find(params[:id])
    @label.destroy

    respond_to do |format|
      flash[:notice] = "Label '#{@label}' was destroyed."
      format.html { redirect_to labels_url }
      format.xml  { head :ok }
      format.js   # destroy.rjs
    end
  end

  # GET /labels;manage
  def manage
    @labels = Label.find(:all)
  end
end
