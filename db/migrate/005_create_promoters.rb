class CreatePromoters < ActiveRecord::Migration
  def self.up
    create_table :promoters do |t|
      t.column :name, :string
      t.column :contact_name, :string
      t.column :email, :string
      t.column :phone, :string

      t.column :created_at, :datetime
      t.column :updated_at, :datetime
    end
  end

  def self.down
    drop_table :promoters
  end
end
