class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string   :type                    
      t.string   :login                     
      t.string   :email                    
      t.string   :crypted_password, :limit => 40
      t.string   :salt,             :limit => 40
                                               
      t.string   :status
                                              
      t.string   :first_name             
      t.string   :last_name                  
      t.string   :phone
      
      t.date     :joined_on            
                                              
      t.string   :remember_token         
      t.datetime :remember_token_expires_at 
                                              
      t.string   :activation_code,  :limit => 40
      t.datetime :activated_at          
                                              
      t.datetime :created_at                
      t.datetime :updated_at                 
    end
  end

  def self.down
    drop_table :users
  end
end
