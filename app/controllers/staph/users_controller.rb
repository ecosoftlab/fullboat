class Staph::UsersController < StaphController
  
  access_rule 'admin || staph_director', :only => [:destroy]

  # GET /users
  def index
    redirect_to staph_root_url
  end

  # GET /users/new
  def new
    @page_title = "Create A New User"    
  end
  
  def show
    @user = User.find(params[:id])
  end
  
  # GET /users/andrew;edit
  def edit
    @page_title = "Edit User"
        
    @user = User.find(params[:id])
    if current_user == @user || has_permission?('admin')
      respond_to do |format|
        format.html # edit.rhtml
        format.xml    { render :xml => @user.to_xml }
      end
    else
      access_denied
    end
  end
  
  # PUT /users/andrew
  def update
    @user = User.find(params[:id])
    update_roles
    
    respond_to do |format|
      if @user.update_attributes(params[:user])
        flash[:notice] = 'User was successfully updated.'        
        format.html { redirect_to user_path(@user) }
        format.xml  { head :ok }
        format.js   { render :action => :success}
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @user.errors.to_xml }
        format.js   { render :action => :error }
      end
    end
  end

  # POST /users
  def create
    @user = User.new(params[:user])
    update_roles
    @user.save!
    
    respond_to do |format|
      format.html { flash[:notice] = "User was successfully created"
                    redirect_to users_url
                  }
      format.js   { render :action => :success}
    end
    
  rescue ActiveRecord::RecordInvalid
    respond_to do |format|
      format.html { render :action => :new }
      format.js   { render :action => :error }
    end
  end
  
  # DELETE /users/andrew
  def destroy
    @user = User.find(params[:id])
    @user.destroy
    
    respond_to do |format|
      format.html { redirect_to users_url }
      format.xml  { render :xml => @user.to_xml}
      format.js   # destroy.rjs
    end
  end

  def activate
    self.current_user = User.find_by_activation_code(params[:activation_code])
    if logged_in? && !current_user.activated?
      current_user.activate
      flash[:notice] = "Signup complete!"
    end
    redirect_back_or_default('/')
  end

private

  def update_roles
    roles = params.delete_if{|k,v| ! k.include?("role_")}.keys.collect{|r| r.gsub(/^role_/, "")}
    @user.roles = roles.collect{|r| Role.find_by_title(r)}.compact
    @user.save
  end
end