class CreatePlaylists < ActiveRecord::Migration
  def self.up
    create_table :playlists do |t|
      t.integer  :user_id
      t.integer  :program_id
                            
      t.datetime :starts_at
      t.datetime :ends_at                      
    end
  end

  def self.down
    drop_table   :playlists
  end
end
