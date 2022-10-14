class Recipe < ApplicationRecord
  belongs_to :user

  validates :title, :description, :process, presence: true
end
