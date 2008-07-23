class CreateFormats < ActiveRecord::Migration
  def self.up
    create_table :formats do |t|
      t.string   :name
      t.string   :description
                            
      t.timestamps
    end
    
    add_index    :formats, :name
  end

  def self.down
    drop_table :formats
  end
end
