class FormatsController < ApplicationController
  before_filter :login_required

  # GET /formats
  # GET /formats.xml
  def index
    @formats = Format.find(:all)

    options = { :feed => { :title       => "Formats",
                           :description => "",
                           :language    => "en-us" },
                :item => { :title       => :title,
                           :description => :description,
                           :pub_date    => :created_at }
              }

    respond_to do |format|
      format.html # index.rhtml
      format.xml  { render :xml => @formats.to_xml }
      format.rss  { render_rss_feed_for @formats,
                      options.update({:link => formatted_formats_url(:rss)})
                  }
      format.atom { render_atom_feed_for @formats,
                      options.update({:link => formatted_formats_url(:atom)})
                  }
    end
  end

  # GET /formats/1
  # GET /formats/1.xml
  def show
    @format = Format.find(params[:id])

    respond_to do |format|
      format.html # show.rhtml
      format.xml  { render :xml => @format.to_xml }
    end
  end

  # GET /formats/new
  def new
    @format = Format.new
  end

  # GET /formats/1;edit
  def edit
    @format = Format.find(params[:id])
  end

  # POST /formats
  # POST /formats.xml
  def create
    @format = Format.new(params[:format])
    @format.save!

    respond_to do |format|
      flash[:notice] = 'Format was successfully created.'
      format.html { redirect_to format_url(@format) }
      format.xml  { head :created, :location => format_url(@format) }
      format.js   { render :template => 'formats/success' }
    end

  rescue ActiveRecord::RecordInvalid
    respond_to do |format|
        format.html { render :action => :new }
        format.xml  { render :xml => @format.errors.to_xml }
        format.js   { render :template => 'formats/error' }
    end
  end

  # PUT /formats/1
  # PUT /formats/1.xml
  def update
    @format = Format.find(params[:id])

    respond_to do |format|
      if @format.update_attributes(params[:format])
        flash[:notice] = "Format '#{@format}' was successfully updated."
        format.html { redirect_to format_url(@format) }
        format.xml  { head :ok }
        format.js   { render :template => 'formats/success' }
      else
        format.html { render :action => :edit }
        format.xml  { render :xml => @format.errors.to_xml }
        format.js   { render :template => 'formats/error' }
      end
    end
  end

  # DELETE /formats/1
  # DELETE /formats/1.xml
  def destroy
    @format = Format.find(params[:id])
    @format.destroy

    respond_to do |format|
      flash[:notice] = "Format '#{@format}' was destroyed."
      format.html { redirect_to formats_url }
      format.xml  { head :ok }
      format.js   # destroy.rjs
    end
  end
end
