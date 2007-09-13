class CreatePlays < ActiveRecord::Migration
  def self.up
    create_table :plays do |t|
      t.column :playlist_id, :int
      t.column :parent_id, :int
      t.column :track_name, :string
      t.column :is_request, :bool
      t.column :is_bincut, :bool
      t.column :is_marked, :bool
      t.column :type, :enum, :limit => ['psa','album','promo','underwriting_contract']

      t.column :created_at, :datetime
      t.column :updated_at, :datetime
    end
  end

  def self.down
    drop_table :plays
  end
end
