class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :dream
  has_many :replies

  validates :text, presence: true
end
