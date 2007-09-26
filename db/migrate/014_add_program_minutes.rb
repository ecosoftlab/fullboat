class AddProgramMinutes < ActiveRecord::Migration
  def self.up
    add_column :programs, :start_minute, :integer
    add_column :programs, :end_minute, :integer
  end

  def self.down
    remove_column :programs, :end_minute
    remove_column :programs, :start_minute
  end
end
