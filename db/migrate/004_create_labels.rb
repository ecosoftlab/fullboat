class CreateLabels < ActiveRecord::Migration
  def self.up
    create_table :labels do |t|
      t.column :name, :string
      t.column :contact_name, :string
      t.column :email, :string
      t.column :address, :string
      t.column :city, :string
      t.column :state, :string
      t.column :zip, :int
      t.column :country, :string
      t.column :fax, :string
      t.column :phone, :string
      t.column :note, :text

      t.column :created_at, :datetime
      t.column :updated_at, :datetime
    end
  end

  def self.down
    drop_table :labels
  end
end
