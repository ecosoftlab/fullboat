namespace :sample do
  task :all => [:users, :genres, :labels, :albums, :psas, :promos, :programs, :events]
  
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
                   :email => email,
                   :street => "%d Main St." % (rand(400) + 100).to_s,
                   :extended => "Suite %d"  % (rand(400) + 100).to_s,
                   :city => "Portland",
                   :state => "OR",
                   :zip => "10000")
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
      artist = Artist.find_or_create_by_name($1.strip)
      album = Album.create(:name => $2.strip, 
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
  
  task :psas => [:environment] do
    ("A".."Z").each do |l|
      PSA.create(:name => l, :code => l, :duration => 30, :body => "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.")
    end
  end
  
  task :promos => [:environment] do
    ("A".."Z").each do |l|
      Promo.create(:name => l, :code => l, :duration => 5 + rand(20),:body => "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
      ")
    end
  end
  
  task :programs => [:environment] do
    require 'program'
    
    Schedule.create(:name => "Spring 2008", :description => "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.", :starts_at => Time.parse("1/21/2008 00:00"), :ends_at => Time.parse("5/5/2008 00:00"))
    
    
    create_program "Aeroflot",                        "Sunday", "00:00", "2:00" 
    create_program "One to One",                      "Sunday", "6:00",  "12:00"
    create_program "Something Fell",                  "Sunday", "12:00", "14:00"
    create_program "The Best of Broadway",            "Sunday", "14:00", "15:00"
    create_program "Classics",                        "Sunday", "15:00", "16:00"
    create_program "Scams, Scandals and Skulduggery", "Sunday", "16:00", "18:00"
    create_program "The Best Kept Secret Radio Show", "Sunday", "19:00", "21:00"
    create_program "Sound Smorgasbord",               "Sunday", "21:00", "23:00"
  end
  
  
  task :events => [:environment] do 
    venues = ["Andy Warhol Museum", "Carnegie Museum", "Mr. Small's", "Shadow Lounge", "Brillobox"]
    
    (0..29).each_with_index do |i|
      day = Date.today + rand(15).days
      Event.create(:name => Artist.find(rand(Artist.count) + 1).to_s + " Concert", :location => venues[rand(venues.length)], 
      :starts_at => day, :ends_at => day + 4.hours, :phone => "555 555 2324", :url => 'http://wrct.org')
    end
  end
end

def create_program(name, day, start_time, end_time)
  days = %w{Sunday Monday Tuesday Wednesday Thursday Friday Saturday}
  day = days.index(day) || day
  program = MusicProgram.create!(:name => name, :description => "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.")
  (rand(2) + 1).times{program.users << User.find(rand(User.count) + 1)}
  program.save
  slot = Slot.new(:schedule_id => Schedule.find(:first).id, 
           :day => day, :start_time => Time.parse(start_time), :end_time => Time.parse(end_time))
  slot.program = program
  slot.save!
end