class PlaylistsController < ApplicationController
  before_filter :login_required

  # Music Section
  layout 'music'
  
  # in_place_edit_for :start_time, :end_time
  
  # GET /playlists
  # GET /playlists.xml
  def index
    @playlists = Playlist.find(:all)

    respond_to do |format|
      format.html # index.rhtml
      format.xml  { render :xml => @playlists.to_xml }
    end
  end

  # GET /playlists/1
  # GET /playlists/1.xml
  def show
    @playlist = Playlist.find(params[:id])
    
    options = { :feed => { :title       => @playlist,
                           :description => "",
                           :language    => "en-us" },
                :item => { :title       => :name,
                           :pub_date    => :created_at }
              }

    respond_to do |format|
      format.html # show.rhtml
      format.xml  { render :xml => @playlist.to_xml }
      format.rss  { render_rss_feed_for @playlist.plays, 
                      options.update({:link => formatted_playlists_url(:rss)}) 
                  }
      format.atom { render_atom_feed_for @playlist.plays, 
                      options.update({:link => formatted_playlists_url(:atom)}) 
                  }
    end
  end

  # GET /playlists/new
  def new
    @playlist = Playlist.new
  end

  # GET /playlists/1;edit
  def edit
    @playlist = Playlist.find(params[:id])
  end

  # POST /playlists
  # POST /playlists.xml
  def create
    @playlist = Playlist.new(params[:playlist])
    @playlist.user = current_user
    case type = params[:_type]
    when 'program'
      @playlist.program = Program.find(params[:program_id])
    else
      # random playlist
    end
    
    @playlist.save!

    respond_to do |format|
      flash[:notice] = 'Playlist was successfully created.'
      format.html { redirect_to @playlist.album ?
                      program_playlist_url(@program, @playlist) :
                      playlist_url(@playlist)
                  }
      format.xml  { head :created, :location => playlist_url(@playlist) }
      format.js   { render :template => 'playlists/success' }
    end
    
  rescue ActiveRecord::RecordInvalid
    respond_to do |format|
        format.html { render :action => :new }
        format.xml  { render :xml => @playlist.errors.to_xml }
        format.js   { render :template => 'playlists/error' }
    end
  end

  # PUT /playlists/1
  # PUT /playlists/1.xml
  def update
    @playlist = Playlist.find(params[:id])

    respond_to do |format|
      if @playlist.update_attributes(params[:playlist])
        flash[:notice] = "Playlist '#{@playlist}' was successfully updated."
        format.html { redirect_to playlist_url(@playlist) }
        format.xml  { head :ok }
        format.js   { render :template => 'playlists/success' }
      else
        format.html { render :action => :edit }
        format.xml  { render :xml => @playlist.errors.to_xml }
        format.js   { render :template => 'playlists/error' }
      end
    end
  end

  # DELETE /playlists/1
  # DELETE /playlists/1.xml
  def destroy
    @playlist = Playlist.find(params[:id])
    @playlist.destroy

    respond_to do |format|
      flash[:notice] = "Playlist '#{@playlist}' was destroyed."
      format.html { redirect_to playlists_url }
      format.xml  { head :ok }
      format.js   # destroy.rjs
    end
  end
  
  def auto_complete_for_artist_name
    name = params[:artist][:name]
    @artists = Artist.search(name) unless name.blank?
    render :partial => "artists/autocomplete"
  end
  
  # GET /playlists;manage
  def manage
    redirect_to manage_programs_url
  end
  
  def remote_update_albums
    @artist = Artist.find_by_name(params[:artist])
    @albums = @artist.albums rescue []
    render :action => "playlists/remote_update_albums", :layout => false
  end
  
  def remote_update_tracks
    @album = Album.find(params[:album])
    @tracks = @album.tracks || []
    render :action => "playlists/remote_update_tracks", :layout => false
  end

end
