class CreateHabtmJoinTables < ActiveRecord::Migration
  def self.up
    create_table :programs_users, :id => false do |t|
      t.column :program_id, :int
      t.column :user_id, :int
    end
    
    create_table :programs_schedules, :id => false do |t|
      t.column :program_id, :int
      t.column :schedule_id, :int
    end
    
    create_table :programs_underwriting_contracts, :id => false do |t|
      t.column :program_id, :int
      t.column :underwriting_contract_id, :int
    end
    
    create_table :contributors_programs, :id => false do |t|
      t.column :program_id, :int
      t.column :contributor_id, :int
    end
     
  end

  def self.down
    drop_table :programs_users
    drop_table :programs_schedules
    drop_table :programs_underwriting_contracts
    drop_table :contributors_programs
  end
end
