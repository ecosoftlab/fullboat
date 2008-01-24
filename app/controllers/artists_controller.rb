class ArtistsController < ApplicationController
  before_filter :login_required

  # Music Section
  layout 'music'

  # GET /artists
  # GET /artists.xml
  def index
    conditions = []; values = {}
    if params[:letter] then conditions << "name LIKE :letter"; values[:letter] = "#{params[:letter]}%" end
    
    @artists = Artist.paginate(:all, :conditions => [conditions.join(" AND "), values], 
                               :page => params[:page],
                               :order => "sort_name ASC")

    options = { :feed => { :title       => "Artists",
                           :description => "",
                           :language    => "en-us" },
                :item => { :title       => :title,
                           :description => :description,
                           :pub_date    => :created_at }
              }

    respond_to do |format|
      format.html # index.rhtml
      format.xml  { render :xml => @artists.to_xml }
      format.rss  { render_rss_feed_for @artists,
                      options.update({:link => formatted_artists_url(:rss)})
                  }
      format.atom { render_atom_feed_for @artists,
                      options.update({:link => formatted_artists_url(:atom)})
                  }
    end
  end

  # GET /artists/1
  # GET /artists/1.xml
  def show
    @artist = Artist.find(params[:id])

    respond_to do |format|
      format.html # show.rhtml
      format.xml  { render :xml => @artist.to_xml }
    end
  end

  # GET /artists/new
  def new
    @artist = Artist.new
  end

  # GET /artists/1;edit
  def edit
    @artist = Artist.find(params[:id])
  end

  # POST /artists
  # POST /artists.xml
  def create
    @artist = Artist.new(params[:artist])
    @artist.save!

    respond_to do |format|
      flash[:notice] = 'Artist was successfully created.'
      format.html { redirect_to artist_url(@artist.id) }
      format.xml  { head :created, :location => artist_url(@artist) }
      format.js   { render :template => 'artists/success' }
    end

  rescue ActiveRecord::RecordInvalid
    respond_to do |format|
      format.html { render :action => :new }
      format.xml  { render :xml => @artist.errors.to_xml }
      format.js   { render :template => 'artists/error' }
    end
  end

  # PUT /artists/1
  # PUT /artists/1.xml
  def update
    @artist = Artist.find(params[:id])

    respond_to do |format|
      if @artist.update_attributes(params[:artist])
        flash[:notice] = "Artist '#{@artist.name}' was successfully updated."
        format.html { redirect_to artist_url(@artist) }
        format.xml  { head :ok }
        format.js   { render :template => 'artists/success' }
      else
        format.html { render :action => :edit }
        format.xml  { render :xml => @artist.errors.to_xml }
        format.js   { render :template => 'artists/error' }
      end
    end
  end

  # DELETE /artists/1
  # DELETE /artists/1.xml
  def destroy
    @artist = Artist.find(params[:id])
    @artist.destroy

    respond_to do |format|
      flash[:notice] = "Artist '#{@artist.name}' was destroyed."
      format.html { redirect_to artists_url }
      format.xml  { head :ok }
      format.js   # destroy.rjs
    end
  end
end
