class CreateRoles < ActiveRecord::Migration
  def self.up
    create_table :roles do |t|
      t.column :title,        :string
      t.column :description,  :text

      t.column :created_at,   :datetime
      t.column :updated_at,   :datetime
    end
    
    create_table :roles_users, :id => false do |t|
      t.column :role_id,      :int
      t.column :user_id,      :int
    end
  end

  def self.down
    drop_table :roles
    drop_table :roles_users
  end
end
