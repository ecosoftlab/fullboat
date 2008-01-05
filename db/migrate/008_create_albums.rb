class CreateAlbums < ActiveRecord::Migration
  def self.up
    create_table :albums do |t|
      t.column :name,               :string
      t.column :artist_id,          :integer
      t.column :label_id,           :integer
      t.column :promoter_id,        :integer
      t.column :format_id,          :integer
      t.column :genre_id,           :integer
      t.column :year,               :integer
      t.column :status,             :string
      t.column :status_changed_on,  :date
      t.column :is_compilation,     :boolean

      t.column :created_at, :datetime
      t.column :updated_at, :datetime
    end
  end

  def self.down
    drop_table :albums
  end
end
