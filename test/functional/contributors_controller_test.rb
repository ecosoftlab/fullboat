require File.dirname(__FILE__) + '/../test_helper'
require 'contributors_controller'

# Re-raise errors caught by the controller.
class ContributorsController; def rescue_action(e) raise e end; end

class ContributorsControllerTest < Test::Unit::TestCase
  fixtures :contributors

  def setup
    @controller = ContributorsController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_should_get_index
    get :index
    assert_response :success
    assert assigns(:contributors)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end
  
  def test_should_create_contributor
    old_count = Contributor.count
    create_contributor
    assert_equal old_count+1, Contributor.count
    assert_redirected_to manage_contributors_path
  end

  def test_should_show_contributor
    get :show, :id => 1
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => 1
    assert_response :success
  end
  
  def test_should_update_contributor
    put :update, :id => 1, :contributor => { }
    assert_redirected_to manage_contributors_path
  end
  
  def test_should_destroy_contributor
    old_count = Contributor.count
    delete :destroy, :id => 1
    assert_equal old_count-1, Contributor.count    
  end
  
protected

  def create_contributor(options = {})
    post :create, :contributor => { }.merge(options) # Replace with default values
  end
  
end
