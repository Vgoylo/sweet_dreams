class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :note
  has_many :replies
end
