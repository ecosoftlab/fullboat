class CreateReviews < ActiveRecord::Migration
  def self.up
    create_table :reviews do |t|
      t.text     :body
      t.integer  :user_id
      t.integer  :album_id

      t.timestamps
    end

    add_index    :reviews, :user_id
    add_index    :reviews, :album_id, :unique
    add_index    :reviews, [:user_id, :album_id]
  end

  def self.down
    drop_table   :reviews
  end
end
