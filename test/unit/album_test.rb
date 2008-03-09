require File.dirname(__FILE__) + '/../test_helper'

class AlbumTest < Test::Unit::TestCase
  fixtures :albums, :artists, :labels, :genres

  def test_should_create_album
    assert_difference 'Album.count' do
      album = create_album
      assert ! album.new_record?, "#{album.errors.full_messages.to_sentence}"
    end
  end
  
  def test_should_require_name
    assert_not_nil create_album(:name => nil).errors.on(:name)
  end
  
  def test_should_generate_sort_name
    assert_not_nil create_album[:sort_name]
  end
  
  def test_should_preserve_specified_sort_name
    album = create_album(:name      => "_why's poignant guide to ruby soundtrack", 
                         :sort_name => "why's poignant guide to ruby" )
    assert_equal album[:sort_name], "why's poignant guide to ruby"
  end
  
  def test_should_remove_leading_article_or_special_characters_from_sort_name
    # Difference 
    assert_equal create_album(:name => "The Magic Position")[:sort_name],       "Magic Position"
    assert_equal create_album(:name => "A Minor Revival")[:sort_name],          "Minor Revival"
    
    # No Difference
    assert_equal create_album(:name => "There Will Be A Light")[:sort_name],    "There Will Be A Light"
    assert_equal create_album(:name => "At War With The Mystics")[:sort_name],  "At War With The Mystics"
    assert_equal create_album(:name => "54.40")[:sort_name],                    "54.40"
  end
  
  # belongs_to :artist
  def test_should_belong_to_artist
    assert_nothing_thrown do
      album = create_album
      assert_not_nil album.artist
      assert_kind_of Artist, album.artist      
    end
  end
  
  def test_should_require_artist
    assert_no_difference 'Album.count' do
      album = create_album(:artist_id => nil)
      assert album.new_record?
    end
  end
  
  def test_should_not_require_artist_if_compilation
    assert_nothing_thrown do
      album = create_album(:artist_id => nil, :is_compilation => true)
      assert_nil album.artist
    end
  end
  
  # belongs_to :label
  def test_should_belong_to_label
    assert_nothing_thrown do
      album = create_album
      assert_not_nil album.label
      assert_kind_of Label, album.label      
    end
  end
  
  def test_should_not_require_label
    assert_nothing_thrown do
      album = create_album(:label_id => nil)
      assert_nil album.label
    end
  end
  
protected

  def create_album(options = {})
    Album.create(@@album_default_values.merge(options))
  end
end