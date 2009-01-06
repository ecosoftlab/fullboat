class AddUuidColumns < ActiveRecord::Migration
  def self.up
    add_column :artists,  :uuid, :string
    add_column :albums,   :uuid, :string
    add_column :labels,   :uuid, :string
  end

  def self.down
    remove_column :artists,  :uuid
    remove_column :albums,   :uuid
    remove_column :labels,   :uuid
  end
end
