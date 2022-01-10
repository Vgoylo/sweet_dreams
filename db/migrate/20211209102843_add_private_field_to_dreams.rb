# frozen_string_literal: true

class AddPrivateFieldToDreams < ActiveRecord::Migration[6.1]
  def change
    add_column :dreams, :private, :boolean, null: false, default: false
  end
end
