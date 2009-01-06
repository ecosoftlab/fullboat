atom_feed(:url => formatted_tbr_albums_url(:atom)) do |feed|
  feed.title("TBR Albums")
  feed.updated(@albums.any? ? @albums.first.created_at  : Time.now.utc)

  @albums.each do |album|
    feed.entry(album) do |entry|
      entry.title(album.name)
      entry.content(album.description, :type => 'text')

      entry.author do |author|
        author.name("Fullboat")
        author.url(root_url)
      end
    end
  end
end