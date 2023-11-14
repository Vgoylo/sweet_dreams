class RemovePartNumberFromDreams < ActiveRecord::Migration[6.1]
  def change
    remove_column :dreams, :part_number, :string
  end
end
