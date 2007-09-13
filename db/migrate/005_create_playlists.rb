class CreatePlaylists < ActiveRecord::Migration
  def self.up
    create_table :playlists do |t|
      t.column :start_time, :datetime
      t.column :end_time, :datetime
      t.column :user_id, :int
      t.column :program_id, :int

      t.column :created_at, :datetime
      t.column :updated_at, :datetime
    end
  end

  def self.down
    drop_table :playlists
  end
end
