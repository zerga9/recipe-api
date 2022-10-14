# frozen_string_literal: true

class RatingSerializer < ActiveModel::Serializer
  belongs_to :recipe
  belongs_to :user, through: :recipe
  attributes :id, :rating
end
