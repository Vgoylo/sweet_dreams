# frozen_string_literal: true

class Category < ApplicationRecord
  has_many :dreams, dependent: :delete_all

  validates :name, length: { minimum: 3, message: 'Input correct please name category' }

  before_validation :format_name, on: :create

  private

  def format_name
    self.name = name.capitalize
  end
end
