desc 'Creates a test User account'
task :admin => [:environment] do
  configure_database
  u = User.create(:login => 'admin', :password => 'katamari', :password_confirmation => 'katamari', :email => 'nobody@localhost', :name => "Admin McCloud")
  u.activate
end

desc 'Populates databse with sample Roles'
task :roles => [:environment] do
  configure_database
  
  ['admin', 'exec-staph', 'exec-board', 'dj'].each do |r|
    Role.create!(:title => r)
  end
end

desc 'Grants admin access to all accounts'
task :adminify => [:environment] do
  configure_database
  admin = Role.find_by_title('admin')
  User.find(:all).each{|u| u.roles = [admin]; u.save!}
end

def configure_database
  config = ActiveRecord::Base.configurations[RAILS_ENV || 'development']
  ActiveRecord::Base.establish_connection(config)
end