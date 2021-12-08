class ChangeNotesToDreams < ActiveRecord::Migration[6.1]
  def change
    rename_table :notes, :dreams
  end
end
