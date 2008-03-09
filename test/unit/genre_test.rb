require File.dirname(__FILE__) + '/../test_helper'

class GenreTest < Test::Unit::TestCase
  fixtures :genres

  def test_should_create_genre
    assert_difference 'Genre.count' do
      genre = create_genre
      assert ! genre.new_record?, "#{genre.errors.full_messages.to_sentence}"
    end
  end
  
protected

  def create_genre(options = {})
    Genre.create(@@genre_default_values.merge(options))
  end
end
