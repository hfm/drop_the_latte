class Model < ActiveRecord::Migration
  def change
    add_column :photos, :content_file_name, :string
    add_column :photos, :content_content_type, :string
    add_column :photos, :content_file_size, :integer
    add_column :photos, :content_updated_at, :datetime
    add_column :photos, :content, :binary
  end
end
