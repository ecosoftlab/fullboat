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
  end

  def self.down
    drop_table   :programs
  end
end
