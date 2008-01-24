require File.dirname(__FILE__) + '/../test_helper'
require 'genres_controller'

# Re-raise errors caught by the controller.
class GenresController; def rescue_action(e) raise e end; end

class GenresControllerTest < Test::Unit::TestCase
  fixtures :genres

  def setup
    @controller = GenresController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_should_get_index
    get :index
    assert_response :success
    assert assigns(:genres)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end
  
  def test_should_create_genre
    old_count = Genre.count
    create_genre
    assert_equal old_count+1, Genre.count
    assert_redirected_to genres_path
  end

  def test_should_show_genre
    get :show, :id => 1
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => 1
    assert_response :success
  end
  
  def test_should_update_genre
    put :update, :id => 1, :genre => { }
    assert_redirected_to genres_path
  end
  
  def test_should_destroy_genre
    old_count = Genre.count
    delete :destroy, :id => 1
    assert_equal old_count-1, Genre.count    
  end
  
protected

  def create_genre(options = {})
    post :create, :genre => { }.merge(options) # Replace with default values
  end
  
end
