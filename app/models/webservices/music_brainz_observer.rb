class MusicBrainzObserver < ActiveRecord::Observer
  require 'rbrainz'
  include MusicBrainz::Webservice
  
  @@query = Query.new
  
  @@artist_includes = ArtistIncludes.new(
    :releases       => ['Album', 'Official'],
    :track_rels     => true,
    :label_rels     => true
  )
  
  @@release_includes = ReleaseIncludes.new(
    :counts         => true,
    :release_events => true,
    :discs          => true,
    :tracks         => true
  )
  
  # observe :artist, :album
  
  # def after_create(entity)
  #   case entity
  #   when Artist
  #     id = uuid(@@query.get_artists(:name => entity.name))
  #     lookup_artist(entity)
  #   when Album
  #     id = uuid(@@query.get_releases(:name => entity.name))
  #     lookup_album(entity)
  #   end    
  # end
  
protected

  def uuid(result)
    self.entries.first.entity.id.uuid
  end

  def lookup_artist(id)
    result = @@query.get_artist_by_id(id, @@artist_includes)
  end

  def lookup_album(id)
    result = @@query.get_release_by_id(id, @@release_includes)
  end
end
