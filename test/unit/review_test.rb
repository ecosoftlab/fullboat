require File.dirname(__FILE__) + '/../test_helper'

class ReviewTest < Test::Unit::TestCase
  fixtures :reviews, :users, :albums

  # Replace this with your real tests.
  def test_album
    kb_rev = Review.new(:album => Album.find(1),:user => User.find(1),:body => "this is a review")
    assert kb_rev.save
    kb_badrev = Review.new(:user => User.find(1),:body => "this is a review")
    assert !kb_badrev.save
  end

  def test_user
    kb_badrev = Review.new(:album => Album.find(1),:body => "this is a review")
    assert !kb_badrev.save
  end

  def test_body
    kb_badrev = Review.new(:album => Album.find(1),:user => User.find(1))
    assert !kb_badrev.save
  end

end
