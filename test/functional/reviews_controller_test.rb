require File.dirname(__FILE__) + '/../test_helper'
require 'reviews_controller'

# Re-raise errors caught by the controller.
class ReviewsController; def rescue_action(e) raise e end; end

class ReviewsControllerTest < Test::Unit::TestCase
  fixtures :reviews

  def setup
    @controller = ReviewsController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_should_get_index
    get :index
    assert_response :success
    assert assigns(:reviews)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end
  
  def test_should_create_review
    old_count = Review.count
    create_review
    assert_equal old_count+1, Review.count
    assert_redirected_to reviews_path
  end

  def test_should_show_review
    get :show, :id => 1
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => 1
    assert_response :success
  end
  
  def test_should_update_review
    put :update, :id => 1, :review => { }
    assert_redirected_to reviews_path
  end
  
  def test_should_destroy_review
    old_count = Review.count
    delete :destroy, :id => 1
    assert_equal old_count-1, Review.count    
  end
  
protected

  def create_review(options = {})
    post :create, :review => { }.merge(options) # Replace with default values
  end
  
end
