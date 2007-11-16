class RolesController < ApplicationController
  before_filter :login_required
  
  # GET /roles
  # GET /roles.xml
  def index
    @roles = Roles.find(:all)

    options = { :feed => { :title       => "Roles",
                           :description => "",
                           :language    => "en-us" },
                :item => { :title       => :title,
                           :description => :description,
                           :pub_date    => :created_at }
              }

    respond_to do |format|
      format.html # index.rhtml
      format.xml  { render :xml => @roles.to_xml }
      format.rss  { render_rss_feed_for @roles, 
                      options.update({:link => formatted_roles_url(:rss)}) 
                  }
      format.atom { render_atom_feed_for @roles, 
                      options.update({:link => formatted_roles_url(:atom)}) 
                  }
    end
  end

  # GET /roles/1
  # GET /roles/1.xml
  def show
    @roles = Roles.find(params[:id])

    respond_to do |format|
      format.html # show.rhtml
      format.xml  { render :xml => @roles.to_xml }
    end
  end

  # GET /roles/new
  def new
    @roles = Roles.new
  end

  # GET /roles/1;edit
  def edit
    @roles = Roles.find(params[:id])
  end

  # POST /roles
  # POST /roles.xml
  def create
    @roles = Roles.new(params[:roles])
    @roles.save!

    respond_to do |format|
      flash[:notice] = 'Roles was successfully created.'
      format.html { redirect_to roles_url(@roles) }
      format.xml  { head :created, :location => roles_url(@roles) }
      format.js   { render :template => 'roles/success' }
    end
    
  rescue ActiveRecord::RecordInvalid
    respond_to do |format|
        format.html { render :action => :new }
        format.xml  { render :xml => @roles.errors.to_xml }
        format.js   { render :template => 'roles/error' }
    end
  end

  # PUT /roles/1
  # PUT /roles/1.xml
  def update
    @roles = Roles.find(params[:id])

    respond_to do |format|
      if @roles.update_attributes(params[:roles])
        flash[:notice] = "Roles '#{@roles}' was successfully updated."
        format.html { redirect_to roles_url(@roles) }
        format.xml  { head :ok }
        format.js   { render :template => 'roles/success' }
      else
        format.html { render :action => :edit }
        format.xml  { render :xml => @roles.errors.to_xml }
        format.js   { render :template => 'roles/error' }
      end
    end
  end

  # DELETE /roles/1
  # DELETE /roles/1.xml
  def destroy
    @roles = Roles.find(params[:id])
    @roles.destroy

    respond_to do |format|
      flash[:notice] = "Roles '#{@roles}' was destroyed."
      format.html { redirect_to roles_url }
      format.xml  { head :ok }
      format.js   # destroy.rjs
    end
  end
  
  # GET /roles;manage
  def manage
    @roles = Roles.find(:all)
  end
end
