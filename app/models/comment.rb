class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :dream
  has_many :replies, dependent: :delete_all
end
