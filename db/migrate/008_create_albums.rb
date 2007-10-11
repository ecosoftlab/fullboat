class CreateAlbums < ActiveRecord::Migration
  def self.up
    create_table :albums do |t|
      t.column :name, :string
      t.column :artist_id, :int
      t.column :label_id, :int
      t.column :promoter_id, :int
      t.column :format_id, :int
      t.column :genre_id, :int
      t.column :year, :int
      t.column :status, :enum, :limit => [:tbr, :bin, :oob, :nib, :nwc, :missing, :library]
      t.column :status_changed_on, :date
      t.column :is_compilation, :bool

      t.column :created_at, :datetime
      t.column :updated_at, :datetime
    end
  end

  def self.down
    drop_table :albums
  end
end
