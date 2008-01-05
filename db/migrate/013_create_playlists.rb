class CreatePlaylists < ActiveRecord::Migration
  def self.up
    create_table :playlists do |t|
      t.integer  :user_id
      t.integer  :program_id
                            
      t.datetime :start_time
      t.datetime :end_time 
                            
      t.text     :note  
    end
  end

  def self.down
    drop_table   :playlists
  end
end
