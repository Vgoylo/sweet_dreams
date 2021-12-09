class Tag < ApplicationRecord
  has_many :note_tags

  validates :name, presence: true, uniqueness: { case_sensitive: false }
end
