# frozen_string_literal: true

class Reply < ApplicationRecord
  belongs_to :user
  belongs_to :comment

  validates :text, presence: true
end
