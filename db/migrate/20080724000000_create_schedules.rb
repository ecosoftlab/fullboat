class CreateSchedules < ActiveRecord::Migration
  def self.up
    create_table :schedules do |t|
      t.string   :name
      t.text     :description
      t.boolean  :is_current
      t.datetime :starts_at
      t.datetime :ends_at
                            
      t.timestamps
    end
  end

  def self.down
    drop_table :schedules
  end
end
