class AddPaperclipColumnsToFormats < ActiveRecord::Migration
  def self.up
    add_column :formats, :icon_file_name,     :string
    add_column :formats, :icon_content_type,  :string
    add_column :formats, :icon_file_size,     :integer
  end

  def self.down
    remove_column :formats, :icon_file_name
    remove_column :formats, :icon_content_type
    remove_column :formats, :icon_file_size
  end
end
