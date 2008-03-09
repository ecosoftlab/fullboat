require File.dirname(__FILE__) + '/../test_helper'

class CommentTest < Test::Unit::TestCase
  fixtures :comments, :users, :artists

  def test_should_create_comment
    assert_difference 'Comment.count' do
      comment = create_comment
      assert ! comment.new_record?, "#{comment.errors.full_messages.to_sentence}"
    end
  end
  
  def test_should_require_body
    assert_not_nil create_comment(:body => nil).errors.on(:body)
    assert_not_nil create_comment(:body => "").errors.on(:body)
  end
  
  # belongs_to :user
  def test_should_belong_to_user
    assert_nothing_raised do
      comment = create_comment(:user_id => users(:quentin).id)
      assert_not_nil comment.user
      assert_kind_of User, comment.user
    end
  end
  
  def test_should_not_require_user
    assert_nothing_thrown do
      comment = create_comment(:user_id => nil)
      assert_nil comment.user
    end
  end
  
  # belongs_to :commentable, :polymorphic => true
  def test_should_belong_to_commentable
    assert_nothing_raised do
      comment = create_comment
      assert_not_nil comment.commentable
    end
  end
  
  def test_should_require_commentable
    assert_no_difference 'Comment.count' do
      comment = create_comment(:commentable_id => nil, :commentable_type => nil)
      assert comment.new_record?
    end
  end
  
protected

  def create_comment(options = {})
    Comment.create(@@comment_default_values.merge(options))
  end
end
