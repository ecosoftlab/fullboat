class CreatePsas < ActiveRecord::Migration
  def self.up
    create_table :psas do |t|
      t.column :name, :string
      t.column :body, :text
      t.column :code, :string
      t.column :is_live, :bool
      t.column :length, :int
      t.column :expiration_date, :datetime

      t.column :created_at, :datetime
      t.column :updated_at, :datetime
    end
  end

  def self.down
    drop_table :psas
  end
end
