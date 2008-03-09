require File.dirname(__FILE__) + '/../test_helper'

class PlaylistTest < Test::Unit::TestCase
  fixtures :playlists

  def test_should_create_playlist
    assert_difference 'Playlist.count' do
      playlist = create_playlist
      assert ! playlist.new_record?, "#{playlist.errors.full_messages.to_sentence}"
    end
  end
  
protected

  def create_playlist(options = {})
    Playlist.create(@@playlist_default_values.merge(options))
  end
end
