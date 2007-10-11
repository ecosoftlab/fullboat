class AlbumsController < ApplicationController
  
  # GET /albums
  # GET /albums.xml
  def index
    @albums = Album.find(:all)

    options = { :feed => { :title       => "Albums",
                           :description => "",
                           :language    => "en-us" },
                :item => { :title       => :title,
                           :description => :description,
                           :pub_date    => :created_at }
              }

    respond_to do |format|
      format.html # index.rhtml
      format.xml  { render :xml => @albums.to_xml }
      format.rss  { render_rss_feed_for @albums, 
                      options.update({:link => formatted_albums_url(:rss)}) 
                  }
      format.atom { render_atom_feed_for @albums, 
                      options.update({:link => formatted_albums_url(:atom)}) 
                  }
    end
  end

  # GET /albums/1
  # GET /albums/1.xml
  def show
    @album = Album.find(params[:id])

    respond_to do |format|
      format.html # show.rhtml
      format.xml  { render :xml => @album.to_xml }
    end
  end

  # GET /albums/new
  def new
    @album = Album.new
  end

  # GET /albums/1;edit
  def edit
    @album = Album.find(params[:id])
  end

  # POST /albums
  # POST /albums.xml
  def create
    @album = Album.new(params[:album])
    @album.save!

    respond_to do |format|
      flash[:notice] = 'Album was successfully created.'
      format.html { redirect_to album_url(@album) }
      format.xml  { head :created, :location => album_url(@album) }
      format.js   { render :template => 'albums/success' }
    end
    
  rescue ActiveRecord::RecordInvalid
    respond_to do |format|
        format.html { render :action => :new }
        format.xml  { render :xml => @album.errors.to_xml }
        format.js   { render :template => 'albums/error' }
    end
  end

  # PUT /albums/1
  # PUT /albums/1.xml
  def update
    @album = Album.find(params[:id])

    respond_to do |format|
      if @album.update_attributes(params[:album])
        flash[:notice] = "Album '#{@album}' was successfully updated."
        format.html { redirect_to album_url(@album) }
        format.xml  { head :ok }
        format.js   { render :template => 'albums/success' }
      else
        format.html { render :action => :edit }
        format.xml  { render :xml => @album.errors.to_xml }
        format.js   { render :template => 'albums/error' }
      end
    end
  end

  # DELETE /albums/1
  # DELETE /albums/1.xml
  def destroy
    @album = Album.find(params[:id])
    @album.destroy

    respond_to do |format|
      flash[:notice] = "Album '#{@album}' was destroyed."
      format.html { redirect_to albums_url }
      format.xml  { head :ok }
      format.js   # destroy.rjs
    end
  end
  
  # GET /albums;manage
  def manage
    @albums = Album.find(:all)
  end
end
