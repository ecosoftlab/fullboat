require File.dirname(__FILE__) + '/../test_helper'
require 'promoters_controller'

# Re-raise errors caught by the controller.
class PromotersController; def rescue_action(e) raise e end; end

class PromotersControllerTest < Test::Unit::TestCase
  fixtures :promoters

  def setup
    @controller = PromotersController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_should_get_index
    get :index
    assert_response :success
    assert assigns(:promoters)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end
  
  def test_should_create_promoter
    old_count = Promoter.count
    create_promoter
    assert_equal old_count+1, Promoter.count
    assert_redirected_to manage_promoters_path
  end

  def test_should_show_promoter
    get :show, :id => 1
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => 1
    assert_response :success
  end
  
  def test_should_update_promoter
    put :update, :id => 1, :promoter => { }
    assert_redirected_to manage_promoters_path
  end
  
  def test_should_destroy_promoter
    old_count = Promoter.count
    delete :destroy, :id => 1
    assert_equal old_count-1, Promoter.count    
  end
  
protected

  def create_promoter(options = {})
    post :create, :promoter => { }.merge(options) # Replace with default values
  end
  
end
