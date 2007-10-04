desc 'Creates a test User account'
task :admin => [:environment] do
  configure_database
  u = User.create(:login => 'admin', :password => 'katamari', :password_confirmation => 'katamari', :email => 'nobody@localhost')
  u.activate
end

def configure_database
  config = ActiveRecord::Base.configurations[RAILS_ENV || 'development']
  ActiveRecord::Base.establish_connection(config)
end