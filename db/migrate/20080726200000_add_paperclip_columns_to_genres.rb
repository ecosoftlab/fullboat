class AddPaperclipColumnsToGenres < ActiveRecord::Migration
  def self.up
    add_column :genres, :icon_file_name,     :string
    add_column :genres, :icon_content_type,  :string
    add_column :genres, :icon_file_size,     :integer
  end

  def self.down
    remove_column :genres, :icon_file_name
    remove_column :genres, :icon_content_type
    remove_column :genres, :icon_file_size
  end
end
