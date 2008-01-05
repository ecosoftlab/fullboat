class CreatePrograms < ActiveRecord::Migration
  def self.up
    create_table :programs do |t|
      t.column :name, :string
      t.column :description, :text
      t.column :day, :int
      t.column :start_hour, :int
      t.column :end_hour, :int
      t.column :type, :string
      t.column :url, :string

      t.column :created_at, :datetime
      t.column :updated_at, :datetime
    end
  end

  def self.down
    drop_table :programs
  end
end