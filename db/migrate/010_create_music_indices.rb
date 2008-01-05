class CreateMusicIndices < ActiveRecord::Migration
  def self.up
    add_index    :artists,    :name
    add_index    :albums,     :name
    add_index    :promoters,  :name
    add_index    :labels,     :name
    add_index    :genres,     :name
    add_index    :formats,    :name
  end

  def self.down
    remove_index :artists,    :name
    remove_index :albums,     :name
    remove_index :promoters,  :name
    remove_index :labels,     :name
    remove_index :genres,     :name
    remove_index :formats,    :name
  end
end
