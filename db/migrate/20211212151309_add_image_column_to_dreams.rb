# frozen_string_literal: true

class AddImageColumnToDreams < ActiveRecord::Migration[6.1]
  def up
    add_column :dreams, :image_file_name, :string
    add_column :dreams, :image_file_size, :integer
    add_column :dreams, :image_content_type, :string
    add_column :dreams, :image_updated_at, :datetime
  end

  def down
    remove_column :dreams, :image_file_name, :string
    remove_column :dreams, :image_file_size, :integer
    remove_column :dreams, :image_content_type, :string
    remove_column :dreams, :image_updated_at, :datetime
  end
end
