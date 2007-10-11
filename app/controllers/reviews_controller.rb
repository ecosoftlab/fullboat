class ReviewsController < ApplicationController
  
  # GET /reviews
  # GET /reviews.xml
  def index
    @reviews = Review.find(:all)

    options = { :feed => { :title       => "Reviews",
                           :description => "",
                           :language    => "en-us" },
                :item => { :title       => :title,
                           :description => :description,
                           :pub_date    => :created_at }
              }

    respond_to do |format|
      format.html # index.rhtml
      format.xml  { render :xml => @reviews.to_xml }
      format.rss  { render_rss_feed_for @reviews, 
                      options.update({:link => formatted_reviews_url(:rss)}) 
                  }
      format.atom { render_atom_feed_for @reviews, 
                      options.update({:link => formatted_reviews_url(:atom)}) 
                  }
    end
  end

  # GET /reviews/1
  # GET /reviews/1.xml
  def show
    @review = Review.find(params[:id])

    respond_to do |format|
      format.html # show.rhtml
      format.xml  { render :xml => @review.to_xml }
    end
  end

  # GET /reviews/new
  def new
    @review = Review.new
  end

  # GET /reviews/1;edit
  def edit
    @review = Review.find(params[:id])
  end

  # POST /reviews
  # POST /reviews.xml
  def create
    @review = Review.new(params[:review])
    @review.save!

    respond_to do |format|
      flash[:notice] = 'Review was successfully created.'
      format.html { redirect_to review_url(@review) }
      format.xml  { head :created, :location => review_url(@review) }
      format.js   { render :template => 'reviews/success' }
    end
    
  rescue ActiveRecord::RecordInvalid
    respond_to do |format|
        format.html { render :action => :new }
        format.xml  { render :xml => @review.errors.to_xml }
        format.js   { render :template => 'reviews/error' }
    end
  end

  # PUT /reviews/1
  # PUT /reviews/1.xml
  def update
    @review = Review.find(params[:id])

    respond_to do |format|
      if @review.update_attributes(params[:review])
        flash[:notice] = "Review '#{@review}' was successfully updated."
        format.html { redirect_to review_url(@review) }
        format.xml  { head :ok }
        format.js   { render :template => 'reviews/success' }
      else
        format.html { render :action => :edit }
        format.xml  { render :xml => @review.errors.to_xml }
        format.js   { render :template => 'reviews/error' }
      end
    end
  end

  # DELETE /reviews/1
  # DELETE /reviews/1.xml
  def destroy
    @review = Review.find(params[:id])
    @review.destroy

    respond_to do |format|
      flash[:notice] = "Review '#{@review}' was destroyed."
      format.html { redirect_to reviews_url }
      format.xml  { head :ok }
      format.js   # destroy.rjs
    end
  end
  
  # GET /reviews;manage
  def manage
    @reviews = Review.find(:all)
  end
end
