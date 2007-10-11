require File.dirname(__FILE__) + '/../test_helper'

class AlbumTest < Test::Unit::TestCase
  fixtures :albums, :artists, :genres, :formats, :labels, :promoters, :users

  # Replace this with your real tests.
  def test_artist
    raag = Album.new(:name => "Raag Manifestos", :artist => Artist.find(1), :label => Label.find(1), :format => Format.find(1), :genre => Genre.find(1), :year => 2004, :status => :oob, :status_changed_on => Time.now, :is_compilation => false)
    assert raag.save
    raag2 = Album.new(:name => "Raag Manifestos", :label => Label.find(1), :format => Format.find(1), :genre => Genre.find(1), :year => 2004, :status => :oob, :status_changed_on => Time.now, :is_compilation => false)
    assert !raag2.save
    raag3 = Album.new(:name => "Raag Manifestos", :label => Label.find(1), :format => Format.find(1), :genre => Genre.find(1), :year => 2004, :status => :oob, :status_changed_on => Time.now, :is_compilation => true)
    assert raag3.save
  end

  def test_label
    raag = Album.new(:name => "Raag Manifestos", :artist => Artist.find(1), :format => Format.find(1), :genre => Genre.find(1), :year => 2004, :status => :oob, :status_changed_on => Time.now, :is_compilation => false)
    assert !raag.save
  end

  def test_genre
    raag = Album.new(:name => "Raag Manifestos", :artist => Artist.find(1), :label => Label.find(1), :format => Format.find(1), :year => 2004, :status => :oob, :status_changed_on => Time.now, :is_compilation => false)
    assert !raag.save
  end

  def test_format
    raag = Album.new(:name => "Raag Manifestos", :artist => Artist.find(1), :label => Label.find(1), :genre => Genre.find(1), :year => 2004, :status => :oob, :status_changed_on => Time.now, :is_compilation => false)
    assert !raag.save
  end

  def test_year
    raag = Album.new(:name => "Raag Manifestos", :artist => Artist.find(1), :label => Label.find(1), :format => Format.find(1), :genre => Genre.find(1), :year => 20004, :status => :oob, :status_changed_on => Time.now, :is_compilation => false)
    assert !raag.save
  end

  def test_status
    raag = Album.new(:name => "Raag Manifestos", :artist => Artist.find(1), :label => Label.find(1), :format => Format.find(1), :genre => Genre.find(1), :year => 2004, :status => :crapola, :status_changed_on => Time.now, :is_compilation => false)
    assert !raag.save
  end

  def test_status_changed_on
    raag = Album.new(:name => "Raag Manifestos", :artist => Artist.find(1), :label => Label.find(1), :format => Format.find(1), :genre => Genre.find(1), :year => 2004, :status => :crapola, :is_compilation => false)
    assert !raag.save
  end

  def test_is_compilation
    raag = Album.new(:name => "Raag Manifestos", :artist => Artist.find(1), :label => Label.find(1), :format => Format.find(1), :genre => Genre.find(1), :year => 2004, :status => :oob, :status_changed_on => Time.now)
    assert !raag.save
  end

  def test_tags
    kb = Album.find(1)
    assert kb.tag_list.add("Blues","picking","raw","beard")
    assert kb.save
    assert Album.find_tagged_with("raw").include?(kb)
  end

  def test_comments
    kb = Album.find(1)
    kb.comments << Comment.new(:body => "hey this is a comment", :user => User.find(1))
    assert kb.save
    assert 1,kb.comments.count
  end

end
