class Ingredient < ApplicationRecord
  belongs_to :recipe, dependent: :destroy

  validates :name, presence: true
end
