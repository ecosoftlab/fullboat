require File.dirname(__FILE__) + '/../test_helper'
require 'underwriting_contracts_controller'

# Re-raise errors caught by the controller.
class UnderwritingContractsController; def rescue_action(e) raise e end; end

class UnderwritingContractsControllerTest < Test::Unit::TestCase
  fixtures :underwriting_contracts

  def setup
    @controller = UnderwritingContractsController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_should_get_index
    get :index
    assert_response :success
    assert assigns(:underwriting_contracts)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end
  
  def test_should_create_underwriting_contract
    old_count = UnderwritingContract.count
    create_underwriting_contract
    assert_equal old_count+1, UnderwritingContract.count
    assert_redirected_to manage_underwriting_contracts_path
  end

  def test_should_show_underwriting_contract
    get :show, :id => 1
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => 1
    assert_response :success
  end
  
  def test_should_update_underwriting_contract
    put :update, :id => 1, :underwriting_contract => { }
    assert_redirected_to manage_underwriting_contracts_path
  end
  
  def test_should_destroy_underwriting_contract
    old_count = UnderwritingContract.count
    delete :destroy, :id => 1
    assert_equal old_count-1, UnderwritingContract.count    
  end
  
protected

  def create_underwriting_contract(options = {})
    post :create, :underwriting_contract => { }.merge(options) # Replace with default values
  end
  
end
