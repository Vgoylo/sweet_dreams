class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :dream
  has_many :replies
end
