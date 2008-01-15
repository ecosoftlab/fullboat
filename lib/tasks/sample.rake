namespace :sample do
  task :all => [:users, :genres, :labels, :albums]
  
  task :users => [:environment] do
    f = File.read("data/sample/users.txt")
    f.each do |line|
      name, email, date = line.split(/\|/).collect{|x| x.strip}
      u = User.new(:login => email.split(/@/).first.downcase,
                   :email => email.downcase,
                   :password => 'password',
                   :password_confirmation => 'password',
                   :joined_on => Time.parse(date))
      u.name = name.titleize
      u.save
      puts name
    end
  end 
  
  task :genres => [:environment] do
    f = File.read("data/sample/genres.txt")
    f.each do |line|
      Genre.create(:name => line.strip)
      puts line
    end
  end
  
  task :labels => [:environment] do
    f = File.read("data/sample/labels.txt")
    f.each do |line|
      line.strip!
      phone = ""; 10.times{phone << rand(10).to_s}
      contact = ((rand(2) == 0) ? "John" : "Jane") + " Doe"
      email = "mail@#{line.gsub(/\W/,'')}.egg"
      Label.create(:name => line, 
                   :phone => phone, 
                   :contact_name => contact, 
                   :email => email)
      puts line
    end
  end
  
  task :albums => [:environment] do
    users  = User.find(:all)
    labels = Label.find(:all)
    
    rock   = Genre.find_by_name("Rock")
    
    f = File.read("data/sample/albums.txt")
    f.each do |line|
      line =~ /(.*):(.*)/
      next if $1.nil? || $2.nil?
      puts "#{$1}\t\t#{$2}"
      artist = Artist.find_or_create_by_name($1)
      album = Album.create(:name => $2, 
                           :artist_id => artist.id,
                           :label_id  => labels.rand.id, 
                           :genre_id => rock.id,
                           :released_on => Date.today - rand(3000).days) if artist
      
      album.tracks = ["Apple Sauce", "Bertrand Russell", "Carotene", "Darth Vader", "Enter the Dragon", "Fortran"]
      album.save
      
      review = Review.create(:user_id => users.rand.id, 
                             :album_id => album.id, 
                             :body => "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.")
    end
  end
end