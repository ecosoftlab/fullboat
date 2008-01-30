class CreateGenres < ActiveRecord::Migration
  def self.up
    create_table :genres do |t|
      t.string   :name
      t.string   :description
      t.integer  :color_code_id
                            
      t.datetime :created_at
      t.datetime :updated_at
    end
    
    add_index    :genres, :name
  end

  def self.down
    drop_table   :genres
  end
end
