class CreateLabels < ActiveRecord::Migration
  def self.up
    create_table :labels do |t|
      t.string   :name       
      t.string   :email       
      t.string   :street
      t.string   :extended     
      t.string   :city        
      t.string   :state       
      t.string   :zip         
      t.string   :country     
      t.string   :fax         
      t.string   :phone  
      t.string   :url     
                               
      t.datetime :created_at  
      t.datetime :updated_at  
    end

    add_index    :labels, :name
  end

  def self.down
    drop_table   :labels
  end
end
