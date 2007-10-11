require File.dirname(__FILE__) + '/../test_helper'

class CommentTest < Test::Unit::TestCase
  fixtures :comments

  def test_body_presence
    comm_good = Comment.new(:body => "hi", :user => User.find(1))
    assert comm_good.save
    comm_bad = Comment.new(:user => User.find(1))
    assert !comm_bad.save
  end

  def test_user_presence
    comm_bad = Comment.new(:body => "hi")
    assert !comm_bad.save
  end

end
