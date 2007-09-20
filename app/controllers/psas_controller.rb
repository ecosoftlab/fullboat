class PsasController < ApplicationController
  before_filter :login_required
  
  # GET /psas
  # GET /psas.xml
  def index
    @psas = Psa.find(:all)

    options = { :feed => { :title       => "Psas",
                           :description => "",
                           :language    => "en-us" },
                :item => { :title       => :title,
                           :description => :description,
                           :pub_date    => :created_at }
              }

    respond_to do |format|
      format.html # index.rhtml
      format.xml  { render :xml => @psas.to_xml }
      format.rss  { render_rss_feed_for @psas, 
                      options.update({:link => formatted_psas_url(:rss)}) 
                  }
      format.atom { render_atom_feed_for @psas, 
                      options.update({:link => formatted_psas_url(:atom)}) 
                  }
    end
  end

  # GET /psas/1
  # GET /psas/1.xml
  def show
    @psa = Psa.find(params[:id])

    respond_to do |format|
      format.html # show.rhtml
      format.xml  { render :xml => @psa.to_xml }
    end
  end

  # GET /psas/new
  def new
    @psa = Psa.new
  end

  # GET /psas/1;edit
  def edit
    @psa = Psa.find(params[:id])
  end

  # POST /psas
  # POST /psas.xml
  def create
    @psa = Psa.new(params[:psa])
    @psa.save!

    respond_to do |format|
      flash[:notice] = 'Psa was successfully created.'
      format.html { redirect_to psa_url(@psa) }
      format.xml  { head :created, :location => psa_url(@psa) }
      format.js   { render :template => :success }
    end
    
  rescue ActiveRecord::RecordInvalid
    respond_to do |format|
        format.html { render :action => :new }
        format.xml  { render :xml => @psa.errors.to_xml }
        format.js   { render :template => :error }
    end
  end

  # PUT /psas/1
  # PUT /psas/1.xml
  def update
    @psa = Psa.find(params[:id])

    respond_to do |format|
      if @psa.update_attributes(params[:psa])
        flash[:notice] = "Psa '#{@psa}' was successfully updated."
        format.html { redirect_to psa_url(@psa) }
        format.xml  { head :ok }
        format.js   { render :template => :success }
      else
        format.html { render :action => :edit }
        format.xml  { render :xml => @psa.errors.to_xml }
        format.js   { render :template => :error }
      end
    end
  end

  # DELETE /psas/1
  # DELETE /psas/1.xml
  def destroy
    @psa = Psa.find(params[:id])
    @psa.destroy

    respond_to do |format|
      flash[:notice] = "Psa '#{@psa}' was destroyed."
      format.html { redirect_to psas_url }
      format.xml  { head :ok }
      format.js   # destroy.rjs
    end
  end
  
  # GET /psas;manage
  def manage
    @psas = Psa.find(:all)
  end
end
