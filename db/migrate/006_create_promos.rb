class CreatePromos < ActiveRecord::Migration
  def self.up
    create_table :promos do |t|
      t.column :name, :string
      t.column :body, :text
      t.column :code, :string
      t.column :is_live, :bool
      t.column :length, :int

      t.column :created_at, :datetime
      t.column :updated_at, :datetime
    end
  end

  def self.down
    drop_table :promos
  end
end
