require File.dirname(__FILE__) + '/../test_helper'

class ArtistTest < Test::Unit::TestCase
  fixtures :artists

  # Replace this with your real tests.
  def test_name
    radiohead = Artist.new(:name => "Radiohead", :sort_name => "radioh")
    assert radiohead.save
    blahblah = Artist.new(:sort_name => "radioh")
    assert !blahblah.save
    short = Artist.new(:name => " ", :sort_name => " ")
    assert !short.save
  end

  def test_sort_name
    blahblah = Artist.new(:name => "Radiohead")
    assert !blahblah.save
  end


end
