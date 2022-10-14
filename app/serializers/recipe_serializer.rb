# frozen_string_literal: true

class RecipeSerializer < ActiveModel::Serializer
  belongs_to :user
  has_many :ingredients
  has_many :ratings

  attributes :id, :title, :description, :process
end
