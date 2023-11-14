# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum role: { common: 0, admin: 1 }

  has_many :dreams
  has_many :comments
  has_many :replies

  # after_commit :user_saved_to_db
  # after_update_commit :user_saved_to_db
  # after_create_commit :user_saved_to_db
  after_save :user_saved_to_db

  # paginates_per 15

  private

  def user_saved_to_db
    puts 'User was success save to database'
  end
end
