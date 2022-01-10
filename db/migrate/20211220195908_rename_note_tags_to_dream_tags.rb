# frozen_string_literal: true

class RenameNoteTagsToDreamTags < ActiveRecord::Migration[6.1]
  def change
    rename_table :note_tags, :dream_tags
    rename_column :dream_tags, :note_id, :dream_id
  end
end
