class PromotersController < ApplicationController
  before_filter :login_required

  # GET /promoters
  # GET /promoters.xml
  def index
    @promoters = Promoter.find(:all)

    options = { :feed => { :title       => "Promoters",
                           :description => "",
                           :language    => "en-us" },
                :item => { :title       => :title,
                           :description => :description,
                           :pub_date    => :created_at }
              }

    respond_to do |format|
      format.html # index.rhtml
      format.xml  { render :xml => @promoters.to_xml }
      format.rss  { render_rss_feed_for @promoters,
                      options.update({:link => formatted_promoters_url(:rss)})
                  }
      format.atom { render_atom_feed_for @promoters,
                      options.update({:link => formatted_promoters_url(:atom)})
                  }
    end
  end

  # GET /promoters/1
  # GET /promoters/1.xml
  def show
    @promoter = Promoter.find(params[:id])

    respond_to do |format|
      format.html # show.rhtml
      format.xml  { render :xml => @promoter.to_xml }
    end
  end

  # GET /promoters/new
  def new
    @promoter = Promoter.new
  end

  # GET /promoters/1;edit
  def edit
    @promoter = Promoter.find(params[:id])
  end

  # POST /promoters
  # POST /promoters.xml
  def create
    @promoter = Promoter.new(params[:promoter])
    @promoter.save!

    respond_to do |format|
      flash[:notice] = 'Promoter was successfully created.'
      format.html { redirect_to promoter_url(@promoter) }
      format.xml  { head :created, :location => promoter_url(@promoter) }
      format.js   { render :template => 'promoters/success' }
    end

  rescue ActiveRecord::RecordInvalid
    respond_to do |format|
        format.html { render :action => :new }
        format.xml  { render :xml => @promoter.errors.to_xml }
        format.js   { render :template => 'promoters/error' }
    end
  end

  # PUT /promoters/1
  # PUT /promoters/1.xml
  def update
    @promoter = Promoter.find(params[:id])

    respond_to do |format|
      if @promoter.update_attributes(params[:promoter])
        flash[:notice] = "Promoter '#{@promoter}' was successfully updated."
        format.html { redirect_to promoter_url(@promoter) }
        format.xml  { head :ok }
        format.js   { render :template => 'promoters/success' }
      else
        format.html { render :action => :edit }
        format.xml  { render :xml => @promoter.errors.to_xml }
        format.js   { render :template => 'promoters/error' }
      end
    end
  end

  # DELETE /promoters/1
  # DELETE /promoters/1.xml
  def destroy
    @promoter = Promoter.find(params[:id])
    @promoter.destroy

    respond_to do |format|
      flash[:notice] = "Promoter '#{@promoter}' was destroyed."
      format.html { redirect_to promoters_url }
      format.xml  { head :ok }
      format.js   # destroy.rjs
    end
  end

  # GET /promoters;manage
  def manage
    @promoters = Promoter.find(:all)
  end
end
