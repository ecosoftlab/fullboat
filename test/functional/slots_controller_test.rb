require File.dirname(__FILE__) + '/../test_helper'
require 'slots_controller'

# Re-raise errors caught by the controller.
class SlotsController; def rescue_action(e) raise e end; end

class SlotsControllerTest < Test::Unit::TestCase
  fixtures :slots

  def setup
    @controller = SlotsController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_should_get_index
    get :index
    assert_response :success
    assert assigns(:slots)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end
  
  def test_should_create_slot
    old_count = Slot.count
    create_slot
    assert_equal old_count+1, Slot.count
    assert_redirected_to slots_path
  end

  def test_should_show_slot
    get :show, :id => 1
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => 1
    assert_response :success
  end
  
  def test_should_update_slot
    put :update, :id => 1, :slot => { }
    assert_redirected_to slots_path
  end
  
  def test_should_destroy_slot
    old_count = Slot.count
    delete :destroy, :id => 1
    assert_equal old_count-1, Slot.count    
  end
  
protected

  def create_slot(options = {})
    post :create, :slot => { }.merge(options) # Replace with default values
  end
  
end
