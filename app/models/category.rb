class Category < ApplicationRecord
  has_many :dreams, dependent: :delete_all
end
