class PlaysController < ApplicationController
  
  # GET /plays
  # GET /plays.xml
  def index
    @plays = Play.find(:all)

    options = { :feed => { :title       => "Plays",
                           :description => "",
                           :language    => "en-us" },
                :item => { :title       => :title,
                           :description => :description,
                           :pub_date    => :created_at }
              }

    respond_to do |format|
      format.html # index.rhtml
      format.xml  { render :xml => @plays.to_xml }
      format.rss  { render_rss_feed_for @plays, 
                      options.update({:link => formatted_plays_url(:rss)}) 
                  }
      format.atom { render_atom_feed_for @plays, 
                      options.update({:link => formatted_plays_url(:atom)}) 
                  }
    end
  end

  # GET /plays/1
  # GET /plays/1.xml
  def show
    @play = Play.find(params[:id])

    respond_to do |format|
      format.html # show.rhtml
      format.xml  { render :xml => @play.to_xml }
    end
  end

  # GET /plays/new
  def new
    @play = Play.new
  end

  # GET /plays/1;edit
  def edit
    @play = Play.find(params[:id])
  end

  # POST /plays
  # POST /plays.xml
  def create
    @play = Play.new(params[:play])
    @play.playlist_id = params[:playlist_id]
    case params[:type]
    when 'album-track'
      @play.playable = Album.find(params[:album])
      @play.name = params[:track]
    when 'psa'
      @play.playable = PSA.find_by_code(params[:psa][:code])
    when 'promo'
      @play.playable = Promo.find_by_code(params[:promo][:code])
    when 'comment'
      comment = Comment.new(params[:comment])
      comment.user = current_user
      @play.playable = comment
    end
    
    raise ActiveRecord::RecordNotFound if @play.playable.nil?
    
    @play.save!

    respond_to do |format|
      flash[:notice] = 'Play was successfully created.'
      format.html { redirect_to play_url(@play) }
      format.xml  { head :created, :location => play_url(@play) }
      format.js   { render :template => 'plays/success' }
    end
  rescue ActiveRecord::RecordNotFound
    flash[:error] = "No record was found"
  
    respond_to do |format|
      format.html { render :action => :new }
      format.xml  { render :xml => @play.errors.to_xml }
      format.js   { render :template => 'plays/error' }
    end
  rescue ActiveRecord::RecordInvalid
    respond_to do |format|
        format.html { render :action => :new }
        format.xml  { render :xml => @play.errors.to_xml }
        format.js   { render :template => 'plays/error' }
    end
  end

  # PUT /plays/1
  # PUT /plays/1.xml
  def update
    @play = Play.find(params[:id])

    respond_to do |format|
      if @play.update_attributes(params[:play])
        flash[:notice] = "Play '#{@play}' was successfully updated."
        format.html { redirect_to play_url(@play) }
        format.xml  { head :ok }
        format.js   { render :template => 'plays/success' }
      else
        format.html { render :action => :edit }
        format.xml  { render :xml => @play.errors.to_xml }
        format.js   { render :template => 'plays/error' }
      end
    end
  end

  # DELETE /plays/1
  # DELETE /plays/1.xml
  def destroy
    @play = Play.find(params[:id])
    @play.destroy

    respond_to do |format|
      flash[:notice] = "Play '#{@play}' was destroyed."
      format.html { redirect_to plays_url }
      format.xml  { head :ok }
      format.js   # destroy.rjs
    end
  end
  
  # GET /plays;manage
  def manage
    @plays = Play.find(:all)
  end
end
