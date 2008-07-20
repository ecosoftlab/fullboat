namespace :legacy do
  namespace :migrate do
    task :all => [:users, :artists, :labels, :genres, :albums, :reviews, :programs, :playlists]
    
    task :connect => [:environment] do
      class Proxy < ActiveRecord::Base
        establish_connection "legacy" 
      end
    end
    
    task :users => [:connect] do
      Proxy.set_table_name "Users"
      Proxy.find_by_sql("SELECT * FROM Users").each do |row|
        User.create do |u|
          u.login      = row["User"].downcase
          u.first_name = row["FName"].titleize
          u.last_name  = row["LName"].titleize
          u.dj_name    = row["DJName"]
        
          u.phone = row["Phone"].gsub(/\D/, '') rescue nil
          u.email = row["Email"]
          u.email += "@andrew.cmu.edu" if u.email !=~ /@/
          
          pw = "Pa55word"
          u.password = pw
          u.password_confirmation = pw
          
          u.activated_at = Time.now  
        
          puts u.login
        end
      end
    end
    
    task :artists => [:connect] do
      Proxy.set_table_name "Artists"
      Proxy.find_by_sql("SELECT * FROM Artists").each do |row|
        Artist.create do |a|
          a.name = row["Artist"].strip
          
          puts a.name
        end
      end
    end
    
    task :labels => [:connect] do
      Proxy.set_table_name "Labels"
      Proxy.find_by_sql("SELECT * FROM Labels").each do |row|
        label = Label.create do |l|
          l.name = row["Label"].strip
          l.email = row["Email"]
          l.street = row["Address"]
          l.city = row["City"]
          l.state = row["State"]
          l.zip = row["Zip"]
          l.country = row["Country"] || "United States"
          
          l.phone = row["Phone"].gsub(/\D/,'') rescue nil
          l.fax = row["Fax"].gsub(/\D/,'') rescue nil
          
          puts l.name
        end
        
        if row["Comment"]
          label.comments << Comment.create(:body => row["Comment"]) rescue nil
        end
      end
    end
    
    task :genres => [:environment] do
      f = File.read("data/sample/genres.txt")
      f.each do |line|
        Genre.create(:name => line.strip)
        
        puts line
      end
    end
    
    task :albums => [:connect] do
      Proxy.set_table_name "Albums"
      Proxy.find_by_sql("SELECT Albums.*,  Formats.Format, Genres.Genre, Labels.Label, Artists.Artist FROM Albums
                          INNER JOIN Artists ON Artists.ArtistID = Albums.ArtistID 
                          INNER JOIN Labels ON Labels.LabelID = Albums.LabelID
                          INNER JOIN Genres ON Genres.GenreID = Albums.GenreID
                          INNER JOIN Formats ON Formats.FormatID = Albums.FormatID").each do |row|
        Album.create do |a|
          a.artist = Artist.find_by_name(row["Artist"].strip) rescue nil
          a.label  = Label.find_by_name(row["Label"].strip)   rescue nil
          a.genre  = Genre.find_by_name(row["Genre"].strip)   rescue nil
          
          a.format = row["Format"]
          
          a.name   = row["Album"].strip
          a.status = row["Status"]
          a.is_compilation = row["Comp"]
          a.created_at = row["DateAdded"].to_time rescue nil
          
          puts a.name
        end
      end
    end
    
    task :programs => [:connect] do
      Proxy.set_table_name "Programs"
      Proxy.find_by_sql("SELECT Programs.*, Users.User 
                         FROM Programs INNER JOIN Users 
                         ON Users.UserID = Programs.UserID").each do |row|
        program = Program.create do |p|
          p.users << User.find_by_login(row["User"]) rescue nil
          p.name = row["Program"]
          p.type = case row["program"]
                    when 'pa'   then "PublicAffairsProgram"
                    when 'show' then "MusicProgram" 
                   end
          
          puts p.name
        end
        
        if program
          promo = Promo.create do |p|
            p.name = program.name + " Promo"
            p.body = row["Promo"]
            p.code = row["Promocode"]
            
            puts p.name
          end
          
          program.promos << promo
        end
      end
    end
  
    task :playlists => [:connect] do
      Proxy.set_table_name "Playlists"
      Proxy.find_by_sql("SELECT PlayLists.*,  Users.User, Programs.Program FROM PlayLists
                          INNER JOIN Programs ON Programs.ProgramID = PlayLists.ProgramID 
                          INNER JOIN Users ON Users.UserID = PlayLists.UserID").each do |row|
        begin
          playlist = Playlist.create do |p|
            p.program = Program.find_by_name(row["Program"].strip)
            p.user    = User.find_by_login(row["User"].strip)
          
              p.starts_at   = row["StartTime"]
              p.ends_at     = row["EndTime"]    || p.starts_at + 1.hour
          
        
            puts p.starts_at
          end
        rescue
          next
        end
        
        Proxy.find_by_sql("SELECT Plays.*,  Artists.Artist, Albums.Album FROM Plays
                            INNER JOIN Artists ON Artists.ArtistID = Plays.ArtistID 
                            INNER JOIN Albums ON Albums.AlbumID = Plays.AlbumID
			                      WHERE Plays.PlayListID = #{row['PlayListID']}").each do |nested_row|
			    playlist.plays << Play.create do |p|
		        artist = Artist.find_by_name(nested_row["Artist"].strip)
		        next if artist.nil?
		        p.playable  = Album.find_by_artist_id_and_name(artist.id, nested_row["Album"])
		        p.name = nested_row["TrackName"]
		        p.is_request = (nested_row["R"]    == 'Yes') rescue false
		        p.is_bincut  = (nested_row["B"]    == 'Yes') rescue false
		        p.is_marked  = (nested_row["Mark"] == 'Yes') rescue false
		        p.created_at = nested_row["Time"]
		      end
			  end
      end
    end
  
    task :reviews => [:connect] do
      Proxy.set_table_name "Reviews"
      Proxy.find_by_sql("SELECT Reviews.*, Users.User, Albums.Album FROM Reviews 
	                        INNER JOIN Albums ON Albums.AlbumID = Reviews. AlbumID
	                        INNER JOIN Users ON Users.UserID = Reviews.UserID").each do |row|
	      album = Album.find_by_name(row["Album"].strip)
	      next if album.nil?
	      require 'pp'
	      pp row
	      begin
  	      album.review = Review.create do |r|
                          r.user = User.find_by_login(row["User"])
                          r.body = row["Review"]
                          r.created_at = row["Time"]
                         end
          album.save
        rescue 
          next
        end
	    end
    end
  end
end