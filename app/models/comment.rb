# frozen_string_literal: true

class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :dream
  has_many :replies, dependent: :delete_all

  after_destroy :log_destroy_action

  def log_destroy_action
    puts 'Comments destroyed'
  end
end
