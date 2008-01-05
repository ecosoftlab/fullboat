class CreateGenres < ActiveRecord::Migration
  def self.up
    create_table :genres do |t|
      t.string   :name
                            
      t.datetime :created_at
      t.datetime :updated_at
    end
  end

  def self.down
    drop_table   :genres
  end
end
