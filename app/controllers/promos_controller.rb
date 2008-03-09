class PromosController < ApplicationController
  
  # Programming Section
  layout 'programming'
  
  # GET /promos
  # GET /promos.xml
  def index
    @promos = Promo.find(:all)

    options = { :feed => { :title       => "Promos",
                           :description => "",
                           :language    => "en-us" },
                :item => { :title       => :title,
                           :description => :description,
                           :pub_date    => :created_at }
              }

    respond_to do |format|
      format.html # index.rhtml
      format.xml  { render :xml => @promos.to_xml }
      format.rss  { render_rss_feed_for @promos, 
                      options.update({:link => formatted_promos_url(:rss)}) 
                  }
      format.atom { render_atom_feed_for @promos, 
                      options.update({:link => formatted_promos_url(:atom)}) 
                  }
    end
  end

  # GET /promos/1
  # GET /promos/1.xml
  def show
    @promo = Promo.find(params[:id])

    respond_to do |format|
      format.html # show.rhtml
      format.xml  { render :xml => @promo.to_xml }
    end
  end

  # GET /promos/new
  def new
    @promo = Promo.new
  end

  # GET /promos/1;edit
  def edit
    @promo = Promo.find(params[:id])
  end

  # POST /promos
  # POST /promos.xml
  def create
    @promo = Promo.new(params[:promo])
    @promo.save!

    respond_to do |format|
      flash[:notice] = 'Promo was successfully created.'
      format.html { redirect_to promo_url(@promo) }
      format.xml  { head :created, :location => promo_url(@promo) }
      format.js   { render :template => 'promos/success' }
    end
    
  rescue ActiveRecord::RecordInvalid
    respond_to do |format|
        format.html { render :action => :new }
        format.xml  { render :xml => @promo.errors.to_xml }
        format.js   { render :template => 'promos/error' }
    end
  end

  # PUT /promos/1
  # PUT /promos/1.xml
  def update
    @promo = Promo.find(params[:id])

    respond_to do |format|
      if @promo.update_attributes(params[:promo])
        flash[:notice] = "Promo '#{@promo}' was successfully updated."
        format.html { redirect_to promo_url(@promo) }
        format.xml  { head :ok }
        format.js   { render :template => 'promos/success' }
      else
        format.html { render :action => :edit }
        format.xml  { render :xml => @promo.errors.to_xml }
        format.js   { render :template => 'promos/error' }
      end
    end
  end

  # DELETE /promos/1
  # DELETE /promos/1.xml
  def destroy
    @promo = Promo.find(params[:id])
    @promo.destroy

    respond_to do |format|
      flash[:notice] = "Promo '#{@promo}' was destroyed."
      format.html { redirect_to promos_url }
      format.xml  { head :ok }
      format.js   # destroy.rjs
    end
  end
end
