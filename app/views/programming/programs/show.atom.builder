atom_feed(:url => formatted_program_url(@program, :atom)) do |feed|
  feed.title("Playlists for #{@program}")
  feed.updated(@program.playlists.any? ? @program.playlists.first.starts_at  : Time.now.utc)

  @program.playlists.each do |playlist|
    feed.entry(playlist) do |entry|
      entry.title(playlist)
      entry.content(playlist.description, :type => 'text')

      entry.author do |author|
        author.name(@program.users.to_sentence)
        author.url(program_url(@program))
      end
    end
  end
end