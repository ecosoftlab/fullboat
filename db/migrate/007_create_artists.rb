class CreateArtists < ActiveRecord::Migration
  def self.up
    create_table :artists do |t|
      t.column :name,       :string
      t.column :sort_name,  :string
      t.column :note,       :text

      t.column :created_at, :datetime
      t.column :updated_at, :datetime
    end
  end

  def self.down
    drop_table :artists
  end
end
