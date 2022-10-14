class Ingredient < ApplicationRecord
  belongs_to :recipe, dependent: :destroy

  validates :name, presence: true

  scope :unit, ->(scale) { select(:id, :name, :recipe_id, scale) }
end
