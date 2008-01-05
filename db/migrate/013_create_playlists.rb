class CreatePlaylists < ActiveRecord::Migration
  def self.up
    create_table :playlists do |t|
      t.column :user_id,    :int
      t.column :program_id, :int
      
      t.column :start_time, :datetime
      t.column :end_time,   :datetime
      
      t.column :note,       :text
    end
  end

  def self.down
    drop_table :playlists
  end
end
