require File.dirname(__FILE__) + '/../test_helper'
require 'comments_controller'

# Re-raise errors caught by the controller.
class CommentsController; def rescue_action(e) raise e end; end

class CommentsControllerTest < Test::Unit::TestCase
  fixtures :comments

  def setup
    @controller = CommentsController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_should_get_index
    get :index
    assert_response :success
    assert assigns(:comments)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end
  
  def test_should_create_comment
    old_count = Comment.count
    create_comment
    assert_equal old_count+1, Comment.count
    assert_redirected_to manage_comments_path
  end

  def test_should_show_comment
    get :show, :id => 1
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => 1
    assert_response :success
  end
  
  def test_should_update_comment
    put :update, :id => 1, :comment => { }
    assert_redirected_to manage_comments_path
  end
  
  def test_should_destroy_comment
    old_count = Comment.count
    delete :destroy, :id => 1
    assert_equal old_count-1, Comment.count    
  end
  
protected

  def create_comment(options = {})
    post :create, :comment => { }.merge(options) # Replace with default values
  end
  
end
