require File.dirname(__FILE__) + '/../test_helper'

class ArtistTest < Test::Unit::TestCase
  fixtures :artists

  def test_should_create_artist
    assert_difference 'Artist.count' do
      artist = create_artist
      assert ! artist.new_record?, "#{artist.errors.full_messages.to_sentence}"
    end
  end
  
  def test_should_require_name
    assert_not_nil create_artist(:name => nil).errors.on(:name)
  end
  
  def test_should_generate_sort_name
    assert_not_nil create_artist[:sort_name]
  end
  
  def test_should_preserve_specified_sort_name
    artist = create_artist(:name      => "Luke Vibert", 
                           :sort_name => "Vibert, Luke" )
    assert_equal artist[:sort_name], "Vibert, Luke"
  end
  
  def test_should_remove_leading_article_or_special_characters_from_sort_name
    # Difference 
    assert_equal create_artist(:name => "The Album Leaf")[:sort_name],  "Album Leaf"
    assert_equal create_artist(:name => "The Blank Tapes")[:sort_name], "Blank Tapes"
    
    # No Difference
    assert_equal create_artist(:name => "Thelonius Monk")[:sort_name],  "Thelonius Monk"
    assert_equal create_artist(:name => "50 Foot Wave")[:sort_name],    "50 Foot Wave"
  end
  
protected

  def create_artist(options = {})
    Artist.create(@@artist_default_values.merge(options))
  end
end
