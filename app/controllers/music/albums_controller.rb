class Music::AlbumsController < MusicController
  before_filter :login_required
  
  # GET /albums
  # GET /albums.xml
  def index
    conditions = []; values = {}
    if params[:letter] then conditions << "name LIKE :letter"; values[:letter] = "#{params[:letter]}%" end
    
    @albums = Album.paginate(:all, :conditions => [conditions.join(" AND "), values], 
                               :page => params[:page],
                               :order => "name ASC")

    respond_to do |format|
      format.html # index.rhtml
      format.xml  { render :xml => @albums.to_xml }
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
    @album  = Album.find(params[:id])
    @artist = @album.artist
    @label  = @album.label
    @genre  = @album.genre
  end

  # POST /albums
  # POST /albums.xml
  def create
    @album = Album.new(params[:album])
    @album.artist   = Artist.find_or_create_by_name(params[:artist][:name]) rescue nil
    @album.label    = Label.find_or_create_by_name(params[:label][:name]) rescue nil
    
    @album.save!

    respond_to do |format|
      flash[:notice] = 'Album was successfully created.'
      format.html { redirect_to album_url(@album) }
      format.xml  { head :created, :location => album_url(@album) }
      format.js   { render :template => 'music/albums/success' }
    end

  rescue ActiveRecord::RecordInvalid
    respond_to do |format|
        format.html { render :action => :new }
        format.xml  { render :xml => @album.errors.to_xml }
        format.js   { render :template => 'music/albums/error' }
    end
  end

  # PUT /albums/1
  # PUT /albums/1.xml
  def update
    @album = Album.find(params[:id])
    
    if @album.status != params[:album][:status]
      @album.change_status(params[:album][:status], :user => current_user)
    end
 
    @album.artist   = Artist.find_by_name(params[:artist][:name])
    @album.label    = Label.find_by_name(params[:label][:name])
    @album.genre    = Genre.find(params[:genre][:id])
    
    @album.save!

    respond_to do |format|
      if @album.update_attributes(params[:album])
        flash[:notice] = "Album '#{@album}' was successfully updated."
        format.html { redirect_to album_url(@album) }
        format.xml  { head :ok }
        format.js   { render :template => 'music/albums/success' }
      else
        format.html { render :action => :edit }
        format.xml  { render :xml => @album.errors.to_xml }
        format.js   { render :template => 'music/albums/error' }
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
  
  def tbr
    @albums = Album.paginate_in_state(:all, "TBR", 
                                      :page => params[:page],
                                      :order => "name ASC")
    respond_to do |format|
      format.html # tbr.rhtml
      format.atom # tbr.atom.builder
    end
  end
  
  def yahoo_music_lookup
    require 'yahoo-music'
    @results = Yahoo::Music::Release.search(params[:yahoo_music_query])
    respond_to do |format|
      format.html { render :action => "albums/results/yahoo_music", :layout => false } # if @results
    end
  end  
  
  def last_fm_lookup
    require 'scrobbler'
    @result = Scrobbler::Album.new(params[:last_fm_artist], params[:last_fm_album], :include_info => true)
    respond_to do |format|
      format.html { render :action => "albums/results/last_fm", :layout => false } # if @result
    end
  end
end
