class UnderwritingContractsController < ApplicationController
  
  # GET /underwriting_contracts
  # GET /underwriting_contracts.xml
  def index
    @underwriting_contracts = UnderwritingContract.find(:all)

    options = { :feed => { :title       => "Underwriting_contracts",
                           :description => "",
                           :language    => "en-us" },
                :item => { :title       => :title,
                           :description => :description,
                           :pub_date    => :created_at }
              }

    respond_to do |format|
      format.html # index.rhtml
      format.xml  { render :xml => @underwriting_contracts.to_xml }
      format.rss  { render_rss_feed_for @underwriting_contracts, 
                      options.update({:link => formatted_underwriting_contracts_url(:rss)}) 
                  }
      format.atom { render_atom_feed_for @underwriting_contracts, 
                      options.update({:link => formatted_underwriting_contracts_url(:atom)}) 
                  }
    end
  end

  # GET /underwriting_contracts/1
  # GET /underwriting_contracts/1.xml
  def show
    @underwriting_contract = UnderwritingContract.find(params[:id])

    respond_to do |format|
      format.html # show.rhtml
      format.xml  { render :xml => @underwriting_contract.to_xml }
    end
  end

  # GET /underwriting_contracts/new
  def new
    @underwriting_contract = UnderwritingContract.new
  end

  # GET /underwriting_contracts/1;edit
  def edit
    @underwriting_contract = UnderwritingContract.find(params[:id])
  end

  # POST /underwriting_contracts
  # POST /underwriting_contracts.xml
  def create
    @underwriting_contract = UnderwritingContract.new(params[:underwriting_contract])
    @underwriting_contract.save!

    respond_to do |format|
      flash[:notice] = 'UnderwritingContract was successfully created.'
      format.html { redirect_to underwriting_contract_url(@underwriting_contract) }
      format.xml  { head :created, :location => underwriting_contract_url(@underwriting_contract) }
      format.js   { render :action =>  :success }
    end
    
  rescue ActiveRecord::RecordInvalid
    respond_to do |format|
        format.html { render :action => :new }
        format.xml  { render :xml => @underwriting_contract.errors.to_xml }
        format.js   { render :action =>  :error }
    end
  end

  # PUT /underwriting_contracts/1
  # PUT /underwriting_contracts/1.xml
  def update
    @underwriting_contract = UnderwritingContract.find(params[:id])

    respond_to do |format|
      if @underwriting_contract.update_attributes(params[:underwriting_contract])
        flash[:notice] = "UnderwritingContract '#{@underwriting_contract}' was successfully updated."
        format.html { redirect_to underwriting_contract_url(@underwriting_contract) }
        format.xml  { head :ok }
        format.js   { render :action =>  :success }
      else
        format.html { render :action => :edit }
        format.xml  { render :xml => @underwriting_contract.errors.to_xml }
        format.js   { render :action =>  :error }
      end
    end
  end

  # DELETE /underwriting_contracts/1
  # DELETE /underwriting_contracts/1.xml
  def destroy
    @underwriting_contract = UnderwritingContract.find(params[:id])
    @underwriting_contract.destroy

    respond_to do |format|
      flash[:notice] = "UnderwritingContract '#{@underwriting_contract}' was destroyed."
      format.html { redirect_to underwriting_contracts_url }
      format.xml  { head :ok }
      format.js   # destroy.rjs
    end
  end
  
  # GET /underwriting_contracts;manage
  def manage
    @underwriting_contracts = UnderwritingContract.find(:all)
  end
end
