require File.dirname(__FILE__) + '/../test_helper'

class FormatTest < Test::Unit::TestCase
  fixtures :formats

  # Replace this with your real tests.
  def test_name_validation
    blank_format = Format.new(:name => "")
    assert !blank_format.save
    long_format = Format.new(:name => "aldskfjasdfasjdfaslkdjfhsdflkjahsdflkjsdhflkjsdhf")
    assert !long_format.save
    good_format = Format.new(:name => "cd")
    assert good_format.save
    duplicate_format = Format.new(:name => "cd")
    assert !duplicate_format.save
  end

end
