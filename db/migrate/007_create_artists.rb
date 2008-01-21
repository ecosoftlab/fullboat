class CreateArtists < ActiveRecord::Migration
  def self.up
    create_table :artists do |t|
      t.string   :name
      t.string   :slug
                            
      t.datetime :created_at
      t.datetime :updated_at
    end
  end

  def self.down
    drop_table   :artists
  end
end
