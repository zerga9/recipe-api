# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password

  has_many :recipes, dependent: :destroy
  validates :username, presence: true, uniqueness: true
  validates :password, presence: true, length: { minimum: 6 }
end
