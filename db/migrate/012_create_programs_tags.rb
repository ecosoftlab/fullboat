class CreateProgramsTags < ActiveRecord::Migration
  def self.up
    create_table :programs_tags, :id => false do |t|
      t.column :program_id, :int
      t.column :tag_id, :int
    end
  end

  def self.down
  end
end
