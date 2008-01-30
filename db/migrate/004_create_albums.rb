class CreateAlbums < ActiveRecord::Migration
  def self.up
    create_table :albums do |t|
      t.integer  :artist_id       
      t.integer  :label_id        
      t.integer  :genre_id
      
      t.string   :name
      t.string   :sort_name
      t.string   :status
      t.string   :format
      t.boolean  :is_compilation     
      t.date     :released_on
  
      t.text     :tracks
                
      t.datetime :created_at
      t.datetime :updated_at
    end
    
    add_index    :albums, :name
  end

  def self.down
    drop_table :albums
  end
end
