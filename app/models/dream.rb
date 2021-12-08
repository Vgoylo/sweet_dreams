class Dream < ApplicationRecord
  belongs_to :category
  belongs_to :user
  has_many :note_tags
  has_many :comments
end
