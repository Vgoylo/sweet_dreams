class Dream < ApplicationRecord
  belongs_to :category
  belongs_to :user
  has_many :note_tags
  has_many :comments

  validates :description, :interval, :dream_date, presence: true
  validates :interval, format: { with: /\A\d{2}:\d{2}\s?-\S?\d{2}:\d{2}\Z/, message: "Interval must keep xx:xx-xx:xx format" }
end
