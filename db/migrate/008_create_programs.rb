class CreatePrograms < ActiveRecord::Migration
  def self.up
    create_table :programs do |t|
      t.string   :name       
      t.text     :description
      t.string   :type       
      t.string   :url        
                              
      t.datetime :created_at 
      t.datetime :updated_at 
    end
    
    add_index    :programs, :name
    
    create_table :programs_users, :id => false do |t|
      t.integer  :program_id
      t.integer  :user_id 
    end
  end

  def self.down
    drop_table   :programs
    drop_table   :programs_users
  end
end
