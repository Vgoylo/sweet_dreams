class Category < ApplicationRecord
  has_many :dreams, dependent: :delete_all

  validates :name, presence: true, uniqueness: { case_sensitive: false }
end
