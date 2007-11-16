require File.dirname(__FILE__) + '/../test_helper'
require 'roles_controller'

# Re-raise errors caught by the controller.
class RolesController; def rescue_action(e) raise e end; end

class RolesControllerTest < Test::Unit::TestCase
  fixtures :roles

  def setup
    @controller = RolesController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_should_get_index
    get :index
    assert_response :success
    assert assigns(:roles)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end
  
  def test_should_create_roles
    old_count = Roles.count
    create_roles
    assert_equal old_count+1, Roles.count
    assert_redirected_to manage_roles_path
  end

  def test_should_show_roles
    get :show, :id => 1
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => 1
    assert_response :success
  end
  
  def test_should_update_roles
    put :update, :id => 1, :roles => { }
    assert_redirected_to manage_roles_path
  end
  
  def test_should_destroy_roles
    old_count = Roles.count
    delete :destroy, :id => 1
    assert_equal old_count-1, Roles.count    
  end
  
protected

  def create_roles(options = {})
    post :create, :roles => { }.merge(options) # Replace with default values
  end
  
end
