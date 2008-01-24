require File.dirname(__FILE__) + '/../test_helper'
require 'schedules_controller'

# Re-raise errors caught by the controller.
class SchedulesController; def rescue_action(e) raise e end; end

class SchedulesControllerTest < Test::Unit::TestCase
  fixtures :schedules

  def setup
    @controller = SchedulesController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_should_get_index
    get :index
    assert_response :success
    assert assigns(:schedules)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end
  
  def test_should_create_schedule
    old_count = Schedule.count
    create_schedule
    assert_equal old_count+1, Schedule.count
    assert_redirected_to schedules_path
  end

  def test_should_show_schedule
    get :show, :id => 1
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => 1
    assert_response :success
  end
  
  def test_should_update_schedule
    put :update, :id => 1, :schedule => { }
    assert_redirected_to schedules_path
  end
  
  def test_should_destroy_schedule
    old_count = Schedule.count
    delete :destroy, :id => 1
    assert_equal old_count-1, Schedule.count    
  end
  
protected

  def create_schedule(options = {})
    post :create, :schedule => { }.merge(options) # Replace with default values
  end
  
end
