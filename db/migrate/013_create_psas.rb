class CreatePsas < ActiveRecord::Migration
  def self.up
    create_table :psas do |t|
      t.string   :name   
      t.text     :body   
      t.string   :code
      t.integer  :duration
      t.boolean  :is_live
      t.datetime :expires_on
                            
      t.timestamps
    end
  end

  def self.down
    drop_table :psas
  end
end
