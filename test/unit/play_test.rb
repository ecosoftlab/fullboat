require File.dirname(__FILE__) + '/../test_helper'

class PlayTest < Test::Unit::TestCase
  fixtures :plays, :playlists, :albums

  def test_should_create_play
    assert_difference 'Play.count' do
      play = create_play
      assert ! play.new_record?, "#{play.errors.full_messages.to_sentence}"
    end
  end
  
protected

  def create_play(options = {})
    Play.create(@@play_default_values.merge(options))
  end
end
