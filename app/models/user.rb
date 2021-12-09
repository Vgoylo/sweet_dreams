class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum role: { common: 0, admin: 1 }

  has_many :dreams
  has_many :comments
  has_many :replies

  validates :name, :password, :email, presence: true
  validates :password, format: { with: /\A\d{6,}\Z/, message: 'Should include 6 characters' }
end
