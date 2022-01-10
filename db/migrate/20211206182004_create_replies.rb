# frozen_string_literal: true

class CreateReplies < ActiveRecord::Migration[6.1]
  def change
    create_table :replies do |t|
      t.references :user, null: false, foreign_key: true
      t.string :text, null: false
      t.references :comment, null: false, foreign_key: true

      t.timestamps
    end
  end
end
