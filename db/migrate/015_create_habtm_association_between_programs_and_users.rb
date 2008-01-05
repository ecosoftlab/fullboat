class CreateHabtmAssociationBetweenProgramsAndUsers < ActiveRecord::Migration
  def self.up
    create_table :programs_users, :id => false do |t|
      t.column :program_id, :int
      t.column :user_id,    :int
    end
  end

  def self.down
    drop_table :programs_users
  end
end
