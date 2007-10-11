class CommentsController < ApplicationController
  
  # GET /comments
  # GET /comments.xml
  def index
    @comments = Comment.find(:all)

    options = { :feed => { :title       => "Comments",
                           :description => "",
                           :language    => "en-us" },
                :item => { :title       => :title,
                           :description => :description,
                           :pub_date    => :created_at }
              }

    respond_to do |format|
      format.html # index.rhtml
      format.xml  { render :xml => @comments.to_xml }
      format.rss  { render_rss_feed_for @comments, 
                      options.update({:link => formatted_comments_url(:rss)}) 
                  }
      format.atom { render_atom_feed_for @comments, 
                      options.update({:link => formatted_comments_url(:atom)}) 
                  }
    end
  end

  # GET /comments/1
  # GET /comments/1.xml
  def show
    @comment = Comment.find(params[:id])

    respond_to do |format|
      format.html # show.rhtml
      format.xml  { render :xml => @comment.to_xml }
    end
  end

  # GET /comments/new
  def new
    @comment = Comment.new
  end

  # GET /comments/1;edit
  def edit
    @comment = Comment.find(params[:id])
  end

  # POST /comments
  # POST /comments.xml
  def create
    @comment = Comment.new(params[:comment])
    @comment.save!

    respond_to do |format|
      flash[:notice] = 'Comment was successfully created.'
      format.html { redirect_to comment_url(@comment) }
      format.xml  { head :created, :location => comment_url(@comment) }
      format.js   { render :template => 'comments/success' }
    end
    
  rescue ActiveRecord::RecordInvalid
    respond_to do |format|
        format.html { render :action => :new }
        format.xml  { render :xml => @comment.errors.to_xml }
        format.js   { render :template => 'comments/error' }
    end
  end

  # PUT /comments/1
  # PUT /comments/1.xml
  def update
    @comment = Comment.find(params[:id])

    respond_to do |format|
      if @comment.update_attributes(params[:comment])
        flash[:notice] = "Comment '#{@comment}' was successfully updated."
        format.html { redirect_to comment_url(@comment) }
        format.xml  { head :ok }
        format.js   { render :template => 'comments/success' }
      else
        format.html { render :action => :edit }
        format.xml  { render :xml => @comment.errors.to_xml }
        format.js   { render :template => 'comments/error' }
      end
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.xml
  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy

    respond_to do |format|
      flash[:notice] = "Comment '#{@comment}' was destroyed."
      format.html { redirect_to comments_url }
      format.xml  { head :ok }
      format.js   # destroy.rjs
    end
  end
  
  # GET /comments;manage
  def manage
    @comments = Comment.find(:all)
  end
end
