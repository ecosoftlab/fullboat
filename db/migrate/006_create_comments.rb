class CreateComments < ActiveRecord::Migration
  def self.up
    create_table :comments do |t|
      t.column :body, :text
      t.column :commentable_id, :int
      t.column :commentable_type, :string

      t.column :user_id, :int

      t.column :created_at, :datetime
      t.column :updated_at, :datetime
    end
  end

  def self.down
    drop_table :comments
    drop_table :commentings
  end
end
