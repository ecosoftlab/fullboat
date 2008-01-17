class CreatePromos < ActiveRecord::Migration
  def self.up
    create_table :promos do |t|
      t.string   :name   
      t.text     :body   
      t.string   :code   
      t.integer  :length   
      t.boolean  :is_live
                            
      t.datetime :created_at
      t.datetime :updated_at
    end
  end

  def self.down
    drop_table :promos
  end
end
