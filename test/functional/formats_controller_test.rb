require File.dirname(__FILE__) + '/../test_helper'
require 'formats_controller'

# Re-raise errors caught by the controller.
class FormatsController; def rescue_action(e) raise e end; end

class FormatsControllerTest < Test::Unit::TestCase
  fixtures :formats

  def setup
    @controller = FormatsController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_should_get_index
    get :index
    assert_response :success
    assert assigns(:formats)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end
  
  def test_should_create_format
    old_count = Format.count
    create_format
    assert_equal old_count+1, Format.count
    assert_redirected_to manage_formats_path
  end

  def test_should_show_format
    get :show, :id => 1
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => 1
    assert_response :success
  end
  
  def test_should_update_format
    put :update, :id => 1, :format => { }
    assert_redirected_to manage_formats_path
  end
  
  def test_should_destroy_format
    old_count = Format.count
    delete :destroy, :id => 1
    assert_equal old_count-1, Format.count    
  end
  
protected

  def create_format(options = {})
    post :create, :format => { }.merge(options) # Replace with default values
  end
  
end
