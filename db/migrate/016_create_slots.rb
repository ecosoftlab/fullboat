class CreateSlots < ActiveRecord::Migration
  def self.up
    create_table :slots do |t|
      t.integer  :schedule_id
      t.integer  :program_id
      
      t.integer  :day   
      t.time     :start_time   
      t.time     :end_time    

      t.datetime :created_at
      t.datetime :updated_at
    end
  end

  def self.down
    drop_table :slots
  end
end
