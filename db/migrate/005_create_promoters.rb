class CreatePromoters < ActiveRecord::Migration
  def self.up
    create_table :promoters do |t|
      t.string   :name
      t.string   :contact_name
      t.string   :email      
      t.string   :phone      
                            
      t.datetime :created_at
      t.datetime :updated_at
    end
  end

  def self.down
    drop_table   :promoters
  end
end
