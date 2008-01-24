require File.dirname(__FILE__) + '/../test_helper'
require 'psas_controller'

# Re-raise errors caught by the controller.
class PsasController; def rescue_action(e) raise e end; end

class PsasControllerTest < Test::Unit::TestCase
  fixtures :psas

  def setup
    @controller = PsasController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_should_get_index
    get :index
    assert_response :success
    assert assigns(:psas)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end
  
  def test_should_create_psa
    old_count = Psa.count
    create_psa
    assert_equal old_count+1, Psa.count
    assert_redirected_to psas_path
  end

  def test_should_show_psa
    get :show, :id => 1
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => 1
    assert_response :success
  end
  
  def test_should_update_psa
    put :update, :id => 1, :psa => { }
    assert_redirected_to psas_path
  end
  
  def test_should_destroy_psa
    old_count = Psa.count
    delete :destroy, :id => 1
    assert_equal old_count-1, Psa.count    
  end
  
protected

  def create_psa(options = {})
    post :create, :psa => { }.merge(options) # Replace with default values
  end
  
end
