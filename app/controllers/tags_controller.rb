class TagsController < ApplicationController
  before_filter :login_required
  # GET /tags
  # GET /tags.xml
  def index
    @tags = Tag.find(:all)

    options = { :feed => { :title       => "Tags",
                           :description => "",
                           :language    => "en-us" },
                :item => { :title       => :title,
                           :description => :description,
                           :pub_date    => :created_at }
              }

    respond_to do |format|
      format.html # index.rhtml
      format.xml  { render :xml => @tags.to_xml }
      format.rss  { render_rss_feed_for @tags, 
                      options.update({:link => formatted_tags_url(:rss)}) 
                  }
      format.atom { render_atom_feed_for @tags, 
                      options.update({:link => formatted_tags_url(:atom)}) 
                  }
    end
  end

  # GET /tags/1
  # GET /tags/1.xml
  def show
    @tag = Tag.find(params[:id])

    respond_to do |format|
      format.html # show.rhtml
      format.xml  { render :xml => @tag.to_xml }
    end
  end

  # GET /tags/new
  def new
    @tag = Tag.new
  end

  # GET /tags/1;edit
  def edit
    @tag = Tag.find(params[:id])
  end

  # POST /tags
  # POST /tags.xml
  def create
    @tag = Tag.new(params[:tag])
    @tag.save!

    respond_to do |format|
      flash[:notice] = 'Tag was successfully created.'
      format.html { redirect_to tag_url(@tag) }
      format.xml  { head :created, :location => tag_url(@tag) }
      format.js   { render :template => :success }
    end
    
  rescue ActiveRecord::RecordInvalid
    respond_to do |format|
        format.html { render :action => :new }
        format.xml  { render :xml => @tag.errors.to_xml }
        format.js   { render :template => :error }
    end
  end

  # PUT /tags/1
  # PUT /tags/1.xml
  def update
    @tag = Tag.find(params[:id])

    respond_to do |format|
      if @tag.update_attributes(params[:tag])
        flash[:notice] = "Tag '#{@tag}' was successfully updated."
        format.html { redirect_to tag_url(@tag) }
        format.xml  { head :ok }
        format.js   { render :template => :success }
      else
        format.html { render :action => :edit }
        format.xml  { render :xml => @tag.errors.to_xml }
        format.js   { render :template => :error }
      end
    end
  end

  # DELETE /tags/1
  # DELETE /tags/1.xml
  def destroy
    @tag = Tag.find(params[:id])
    @tag.destroy

    respond_to do |format|
      flash[:notice] = "Tag '#{@tag}' was destroyed."
      format.html { redirect_to tags_url }
      format.xml  { head :ok }
      format.js   # destroy.rjs
    end
  end
  
  # GET /tags;manage
  def manage
    @tags = Tag.find(:all)
  end
end
