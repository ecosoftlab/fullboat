class CreateArtists < ActiveRecord::Migration
  def self.up
    create_table :artists do |t|
      t.string   :name
      t.string   :sort_name
      t.text     :description
                            
      t.datetime :created_at
      t.datetime :updated_at
    end
  end

  def self.down
    drop_table   :artists
  end
end
