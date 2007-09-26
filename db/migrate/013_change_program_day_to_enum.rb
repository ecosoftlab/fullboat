class ChangeProgramDayToEnum < ActiveRecord::Migration
  def self.up
    remove_column :programs, :day
    add_column :programs, :day, :enum, :limit => [:monday, :tuesday, :wednesday, :thursday, :friday, :saturday, :sunday]
  end

  def self.down
    remove_column :programs, :day
    add_column :programs, :day, :int
  end
end
