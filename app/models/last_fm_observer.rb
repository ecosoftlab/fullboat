class LastFmObserver < ActiveRecord::Observer
  require 'scrobbler'
  
  observe :album
  
  def after_create(album)
    last_fm_album = Scrobbler::Album.new(album.artist.name, album.name)
    album.tracks  = last_fm_album.tracks.collect{|t| t.name} rescue []
    album.save
  end
end
