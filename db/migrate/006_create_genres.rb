class CreateGenres < ActiveRecord::Migration
  def self.up
    create_table :genres do |t|
      t.string   :name
      t.string   :description
      t.integer  :color_code_id
                            
      t.timestamps
    end
    
    add_index    :genres, :name
  end

  def self.down
    drop_table   :genres
  end
end
