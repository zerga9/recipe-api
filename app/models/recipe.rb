class Recipe < ApplicationRecord
  belongs_to :user
  has_many :ingredients, dependent: :destroy

  validates :title, :description, :process, presence: true
  accepts_nested_attributes_for :ingredients, allow_destroy: true
end
