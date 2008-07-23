class Staph::RolesController < StaphController
  
  # GET /roles
  # GET /roles.xml
  def index
    @roles = Role.find(:all)

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
    @role = Role.find(params[:id])

    respond_to do |format|
      format.html # show.rhtml
      format.xml  { render :xml => @role.to_xml }
    end
  end

  # GET /roles/new
  def new
    @role = Role.new
  end

  # GET /roles/1;edit
  def edit
    @role = Role.find(params[:id])
  end

  # POST /roles
  # POST /roles.xml
  def create
    @role = Role.new(params[:role])
    @role.save!

    respond_to do |format|
      flash[:notice] = 'Role was successfully created.'
      format.html { redirect_to role_url(@role) }
      format.xml  { head :created, :location => role_url(@role) }
      format.js   { render :template => 'roles/success' }
    end
    
  rescue ActiveRecord::RecordInvalid
    respond_to do |format|
        format.html { render :action => :new }
        format.xml  { render :xml => @role.errors.to_xml }
        format.js   { render :template => 'staph/roles/error' }
    end
  end

  # PUT /roles/1
  # PUT /roles/1.xml
  def update
    @role = Role.find(params[:id])

    respond_to do |format|
      if @role.update_attributes(params[:role])
        flash[:notice] = "Role '#{@role}' was successfully updated."
        format.html { redirect_to role_url(@role) }
        format.xml  { head :ok }
        format.js   { render :template => 'roles/success' }
      else
        format.html { render :action => :edit }
        format.xml  { render :xml => @role.errors.to_xml }
        format.js   { render :template => 'staph/roles/error' }
      end
    end
  end

  # DELETE /roles/1
  # DELETE /roles/1.xml
  def destroy
    @role = Role.find(params[:id])
    @role.destroy

    respond_to do |format|
      flash[:notice] = "Role '#{@role}' was destroyed."
      format.html { redirect_to roles_url }
      format.xml  { head :ok }
      format.js   # destroy.rjs
    end
  end
end
