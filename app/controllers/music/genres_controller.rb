class Music::GenresController < ApplicationController
  before_filter :login_required

  # Music Section
  layout 'music'

  # GET /genres
  # GET /genres.xml
  def index
    @genres = Genre.find(:all)

    options = { :feed => { :title       => "Genres",
                           :description => "",
                           :language    => "en-us" },
                :item => { :title       => :title,
                           :description => :description,
                           :pub_date    => :created_at }
              }

    respond_to do |format|
      format.html # index.rhtml
      format.xml  { render :xml => @genres.to_xml }
      format.rss  { render_rss_feed_for @genres,
                      options.update({:link => formatted_genres_url(:rss)})
                  }
      format.atom { render_atom_feed_for @genres,
                      options.update({:link => formatted_genres_url(:atom)})
                  }
    end
  end

  # GET /genres/1
  # GET /genres/1.xml
  def show
    @genre = Genre.find(params[:id])

    respond_to do |format|
      format.html # show.rhtml
      format.xml  { render :xml => @genre.to_xml }
    end
  end

  # GET /genres/new
  def new
    @genre = Genre.new
  end

  # GET /genres/1;edit
  def edit
    @genre = Genre.find(params[:id])
  end

  # POST /genres
  # POST /genres.xml
  def create
    @genre = Genre.new(params[:genre])
    @genre.save!

    respond_to do |format|
      flash[:notice] = 'Genre was successfully created.'
      format.html { redirect_to genre_url(@genre) }
      format.xml  { head :created, :location => genre_url(@genre) }
      format.js   { render :template => 'genres/success' }
    end

  rescue ActiveRecord::RecordInvalid
    respond_to do |format|
        format.html { render :action => :new }
        format.xml  { render :xml => @genre.errors.to_xml }
        format.js   { render :template => 'genres/error' }
    end
  end

  # PUT /genres/1
  # PUT /genres/1.xml
  def update
    @genre = Genre.find(params[:id])

    respond_to do |format|
      if @genre.update_attributes(params[:genre])
        flash[:notice] = "Genre '#{@genre}' was successfully updated."
        format.html { redirect_to genre_url(@genre) }
        format.xml  { head :ok }
        format.js   { render :template => 'genres/success' }
      else
        format.html { render :action => :edit }
        format.xml  { render :xml => @genre.errors.to_xml }
        format.js   { render :template => 'genres/error' }
      end
    end
  end

  # DELETE /genres/1
  # DELETE /genres/1.xml
  def destroy
    @genre = Genre.find(params[:id])
    @genre.destroy

    respond_to do |format|
      flash[:notice] = "Genre '#{@genre}' was destroyed."
      format.html { redirect_to genres_url }
      format.xml  { head :ok }
      format.js   # destroy.rjs
    end
  end
end
