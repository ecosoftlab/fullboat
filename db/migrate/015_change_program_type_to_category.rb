class ChangeProgramTypeToCategory < ActiveRecord::Migration
  def self.up
    remove_column :programs, :type
    add_column :programs, :category, :enum, :limit => [:music,:public_affairs], :default => :music
  end

  def self.down
    remove_column :programs,:category
    add.column :programs, :type, :enum, :limit => ['music','public_affairs'], :default => 'music'

  end
end
