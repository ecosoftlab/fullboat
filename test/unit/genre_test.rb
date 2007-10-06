require File.dirname(__FILE__) + '/../test_helper'

class GenreTest < Test::Unit::TestCase
  fixtures :genres

  # Replace this with your real tests.
  def test_name_validation
    blank_genre = Genre.new(:name => "")
    assert !blank_genre.save
    long_genre = Genre.new(:name => "aldskfjasdfasjdfaslkdjfhsdflkjahsdflkjsdhflkjsdhf")
    assert !long_genre.save
    good_genre = Genre.new(:name => "rock")
    assert good_genre.save
  end

end
