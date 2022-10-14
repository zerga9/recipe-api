# frozen_string_literal: true

class RecipeSerializer < ActiveModel::Serializer
  belongs_to :user
  has_many :ingredients
  attributes :id, :title, :description, :process
end
