class MusicController < ApplicationController
  layout 'music'
  
  def index
    @recent_albums = Album.recent(:limit => 6)
    @top_albums  = Album.most_played
  end
end
