class AddProgramsUsers < ActiveRecord::Migration
  def self.up
    create_table :programs_users do |t|
      t.column :program_id,  :integer
      t.column :user_id,     :integer
      
      t.column :created_at, :datetime
      t.column :updated_at, :datetime
    end
  
  end

  def self.down
    drop_table :plays
  end
end
