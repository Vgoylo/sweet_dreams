# frozen_string_literal: true

class Dream < ApplicationRecord
  belongs_to :category
  belongs_to :user
  has_many :dream_tags
  has_many :tags, through: :dream_tags
  has_many :comments
  has_attached_file :image, styles: { medium: '300x300>', thumb: '100x100>' }

  validates_attachment_content_type :image, content_type: %r{\Aimage/.*\z}
  validates :description, :interval, :dream_date, presence: true
  validates :interval,
            format: { with: /\A\d{2}:\d{2}\s?-\S?\d{2}:\d{2}\Z/, message: 'Interval must keep xx:xx-xx:xx format' }

  paginates_per 10

  scope :by_user, ->(user_id) { where(user_id: user_id) }
end
