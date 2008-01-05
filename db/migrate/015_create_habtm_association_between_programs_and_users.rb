class CreateHabtmAssociationBetweenProgramsAndUsers < ActiveRecord::Migration
  def self.up
    create_table :programs_users, :id => false do |t|
      t.integer  :program_id
      t.integer  :user_id 
    end
  end

  def self.down
    drop_table   :programs_users
  end
end
