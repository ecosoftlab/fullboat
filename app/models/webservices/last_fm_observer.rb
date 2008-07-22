class LastFmObserver < ActiveRecord::Observer
  require 'scrobbler'
    
  observe :album, :artist
  
  def after_create(entity)
    case entity
    when Album
      lookup_album(entity)
    when Artist
      lookup_artist(entity)
    end
  end
  
protected
  
  def lookup_album(album)
    last_fm_album     = Scrobbler::Album.new(album.artist.name, album.name, :include_info => true)
    #album.image = last_fm_album.image_large
    album.mbid        = last_fm_album.mbid
    album.tracks      = last_fm_album.tracks
    album.released_on = last_fm_album.release_date
    album.save
  end
  
  def lookup_artist(artist)
    last_fm_artist = Scrobbler::Artist.new(artist.name)
    artist.mbid    = last_fm_artist.mdid
    artist.save
  end
end
