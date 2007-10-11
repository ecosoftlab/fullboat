class CreateReviews < ActiveRecord::Migration
  def self.up
    create_table :reviews do |t|
      t.column :body, :text
      t.column :user_id, :int
      t.column :album_id, :int

      t.column :created_at, :datetime
      t.column :updated_at, :datetime
    end

    add_index :reviews, :user_id
    add_index :reviews, :album_id, :unique
    add_index :reviews, [:user_id, :album_id]
  end

  def self.down
    drop_table :reviews
  end
end
