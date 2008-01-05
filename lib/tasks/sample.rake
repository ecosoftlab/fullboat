namespace :sample do
  task :albums => [:environment] do
    f = File.read("data/sample/albums.txt")
    f.each do |line|
      line =~ /(.*):(.*)/
      next if $1.nil? || $2.nil?
      #puts "#{$1}\t\t#{$2}"
      artist = Artist.find_or_create_by_name($1)
      puts artist.name
      Album.create(:name => $2, :artist_id => artist.id, :year => 2000 + rand(8)) if artist
    end
  end
end