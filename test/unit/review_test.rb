require File.dirname(__FILE__) + '/../test_helper'

class ReviewTest < Test::Unit::TestCase
  fixtures :reviews, :users, :albums

  def test_should_create_review
    assert_difference 'Review.count' do
      review = create_review
      assert ! review.new_record?, "#{review.errors.full_messages.to_sentence}"
    end
  end
  
protected

  def create_review(options = {})
    Review.create(@@review_default_values.merge(options))
  end

end
