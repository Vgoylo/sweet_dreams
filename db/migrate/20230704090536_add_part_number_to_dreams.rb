class AddPartNumberToDreams < ActiveRecord::Migration[6.1]
  def change
    add_column :dreams, :part_number, :string
  end
end
