require File.dirname(__FILE__) + '/../test_helper'

class FormatTest < Test::Unit::TestCase
  fixtures :formats

  # Replace this with your real tests.
  def test_name_validation
    blank_genre = Format.new(:name => "")
    assert !blank_genre.save
    long_genre = Format.new(:name => "aldskfjasdfasjdfaslkdjfhsdflkjahsdflkjsdhflkjsdhf")
    assert !long_genre.save
    good_genre = Format.new(:name => "cd")
    assert good_genre.save
  end

end
