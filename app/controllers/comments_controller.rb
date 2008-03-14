class CommentsController < ApplicationController
  
  # GET /comments
  # GET /comments.xml
  def index; end
  
  # GET /comments/1
  # GET /comments/1.xml
  def show; end

  # GET /comments/new
  def new;  end

  # GET /comments/1;edit
  def edit; end 

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
end
