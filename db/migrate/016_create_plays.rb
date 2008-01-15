class CreatePlays < ActiveRecord::Migration
  def self.up
    create_table :plays do |t|
      t.string   :name 
      t.string   :type
      
      t.integer  :playlist_id
      
      t.integer  :playable_id
      t.string   :playable_type 
           
      t.boolean  :is_request
      t.boolean  :is_bincut
      t.boolean  :is_live
      t.boolean  :is_marked
                            
      t.datetime :created_at
    end
  end

  def self.down
    drop_table :plays
  end
end
