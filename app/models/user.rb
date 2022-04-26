class User < ApplicationRecord
  has_many :orders, dependent: :destroy

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i.freeze

  enum role: {user: 0, admin: 1}

  validates :email, format: {with: VALID_EMAIL_REGEX}, presence: true,
    uniqueness: {case_sensitive: false}
  validates :name, presence: true
  validates :password, presence: true
  validates :password, length: {in: Settings.length_8..Settings.length_20}
  has_secure_password
end
