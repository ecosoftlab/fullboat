class Music::ReviewsController < MusicController
  
  skip_before_filter :login_required

  # GET /reviews
  # GET /reviews.xml
  def index
    @reviews = Review.find(:all, :conditions => ["created_at > ?", Date.today.last_month])

    respond_to do |format|
      format.html # index.rhtml
      format.xml  { render :xml => @reviews.to_xml }
      format.atom { render :layout => false}
    end
  end

  # GET /reviews/1
  # GET /reviews/1.xml
  def show
    @review = Review.find(params[:id])

    if @review.album
      respond_to do |format|
        format.html { redirect_to album_url(@review.album) }
        format.xml  { render :xml => @review.to_xml }
      end
    else
    end
  end

  # GET /reviews/new
  def new
    @review = @album.review.new
  end

  # GET /reviews/1;edit
  def edit
    @review = @album.review
  end

  # POST /reviews
  # POST /reviews.xml
  def create
    @review = @album.review.new(params[:review])
    @review.save!

    respond_to do |format|
      flash[:notice] = 'Review was successfully created.'
      format.html { redirect_to review_url(@review) }
      format.xml  { head :created, :location => review_url(@review) }
      format.js   { render :template => 'music/reviews/success' }
    end

  rescue ActiveRecord::RecordInvalid
    respond_to do |format|
        format.html { render :action => :new }
        format.xml  { render :xml => @review.errors.to_xml }
        format.js   { render :template => 'music/reviews/error' }
    end
  end

  # PUT /reviews/1
  # PUT /reviews/1.xml
  def update
    @review = @album.review

    respond_to do |format|
      if @review.update_attributes(params[:review])
        flash[:notice] = "Review '#{@review}' was successfully updated."
        format.html { redirect_to review_url(@review) }
        format.xml  { head :ok }
        format.js   { render :template => 'music/reviews/success' }
      else
        format.html { render :action => :edit }
        format.xml  { render :xml => @review.errors.to_xml }
        format.js   { render :template => 'music/reviews/error' }
      end
    end
  end

  # DELETE /reviews/1
  # DELETE /reviews/1.xml
  def destroy
    @review = @album.review
    @review.destroy

    respond_to do |format|
      flash[:notice] = "Review '#{@review}' was destroyed."
      format.html { redirect_to album_url(@review.album)}
      format.xml  { head :ok }
      format.js   # destroy.rjs
    end
  end
end
