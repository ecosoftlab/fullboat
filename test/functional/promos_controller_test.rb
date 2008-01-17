require File.dirname(__FILE__) + '/../test_helper'
require 'promos_controller'

# Re-raise errors caught by the controller.
class PromosController; def rescue_action(e) raise e end; end

class PromosControllerTest < Test::Unit::TestCase
  fixtures :promos

  def setup
    @controller = PromosController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_should_get_index
    get :index
    assert_response :success
    assert assigns(:promos)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end
  
  def test_should_create_promo
    old_count = Promo.count
    create_promo
    assert_equal old_count+1, Promo.count
    assert_redirected_to manage_promos_path
  end

  def test_should_show_promo
    get :show, :id => 1
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => 1
    assert_response :success
  end
  
  def test_should_update_promo
    put :update, :id => 1, :promo => { }
    assert_redirected_to manage_promos_path
  end
  
  def test_should_destroy_promo
    old_count = Promo.count
    delete :destroy, :id => 1
    assert_equal old_count-1, Promo.count    
  end
  
protected

  def create_promo(options = {})
    post :create, :promo => { }.merge(options) # Replace with default values
  end
  
end
