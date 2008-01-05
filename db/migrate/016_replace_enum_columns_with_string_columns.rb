class ReplaceEnumColumnsWithStringColumns < ActiveRecord::Migration
  # Enums are not well supported in Rails so this migration
  # fails in SQLite because it can't rename columns it
  # doesn't understand.
  
  # Although it's taboo, I'll end up just changing the 
  # migrations themselves
  
  def self.up
    # Users
    rename_column :users, :status, :status_enum
    
    add_column    :users, :status, :string
    add_column    :users, :type,   :string
    
    User.find(:all).each do |u|
      u[:status] = u[:status_enum]
      u[:type]   = u[:affiliation].to_s.capitalize rescue nil 
      u.save
    end
    
    drop_column   :users, :status_enum
    drop_column   :users, :affiliation
    
    # Albums
    rename_column :albums, :status, :status_enum
    
    add_column    :albums, :status, :string
    
    Album.find(:all).each do |a| 
      a[:status] = a[:status_enum]
      a.save
    end
    drop_column   :albums, :status_enum
  end

  def self.down
    # Users
    rename_column :users, :status, :status_string
                  
    add_column    :users, :status, :enum, 
                  :limit => [:active, :inactive, :banned]
    add_column    :users, :affiliation, :enum, 
                  :limit => [:undergraduate, :graduate, :alumni, :community, :faculty, :staff]
    
    User.find(:all).each do |u|
      u[:status]      = u[:status_string]
      u[:affiliation] = u[:type]
      u.save
    end
    drop_column   :users, :status_string
    drop_column   :users, :type    
    
    # Albums
    rename_column :albums, :status, :status_string
    add_column    :albums, :status, :enum, 
                  :limit => [:tbr, :bin, :oob, :nib, :nwc, :missing, :library]
    
    Album.find(:all).each do |a| 
      a[:status] = a[:status_string]
      a.save
    end      
    
    drop_column   :albums, :status_string
  end
end
