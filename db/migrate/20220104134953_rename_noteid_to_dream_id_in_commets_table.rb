class RenameNoteidToDreamIdInCommetsTable < ActiveRecord::Migration[6.1]
  def change
    rename_column :comments, :note_id, :dream_id
  end
end
