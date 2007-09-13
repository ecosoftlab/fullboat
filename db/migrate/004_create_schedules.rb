class CreateSchedules < ActiveRecord::Migration
  def self.up
    create_table :schedules do |t|
      t.column :semester, :enum, :limit => ['fall', 'spring','summer']
      t.column :year, :int
      t.column :start_date, :datetime
      t.column :end_date, :datetime

      t.column :created_at, :datetime
      t.column :updated_at, :datetime
    end
  end

  def self.down
    drop_table :schedules
  end
end
