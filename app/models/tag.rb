# frozen_string_literal: true

class Tag < ApplicationRecord
  has_many :dream_tags

  validates :name, presence: true

  before_validation :format_name, on: :create

  private

  def format_name
    self.name = name.capitalize
  end
end
