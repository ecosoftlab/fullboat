class CreateContributors < ActiveRecord::Migration
  def self.up
    create_table :contributors do |t|
      t.column :first_name, :string
      t.column :last_name, :string
      t.column :email, :string
      t.column :phone, :string

      t.column :created_at, :datetime
      t.column :updated_at, :datetime
    end
  end

  def self.down
    drop_table :contributors
  end
end
