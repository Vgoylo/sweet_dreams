class Dream < ApplicationRecord
  belongs_to :category
  belongs_to :user
  has_many :note_tags
  has_many :comments
  has_attached_file :image, styles: { medium: '300x300>', thumb: '100x100>' }

  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/
  validates :description, :interval, :dream_date, presence: true
  validates :interval, format: { with: /\A\d{2}:\d{2}\s?-\S?\d{2}:\d{2}\Z/, message: "Interval must keep xx:xx-xx:xx format" }

  paginates_per 10
end
