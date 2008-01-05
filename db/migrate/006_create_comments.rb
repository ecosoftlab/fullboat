class CreateComments < ActiveRecord::Migration
  def self.up
    create_table :comments do |t|
      t.integer  :user_id
      t.integer  :commentable_id
      t.string   :commentable_type
                                     
      t.text     :body
                                     
      t.datetime :created_at
      t.datetime :updated_at
    end
  end

  def self.down
    drop_table   :comments
    drop_table   :commentings
  end
end
