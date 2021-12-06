class CreateNotes < ActiveRecord::Migration[6.1]
  def change
    create_table :notes do |t|
      t.date :dream_date, null: false
      t.string :interval, null: false
      t.string :title, null: true, default: 'Untitled'
      t.string :description, null: false
      t.references :category, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
