# frozen_string_literal: true

class UserSerializer < ActiveModel::Serializer
  has_many :recipes
  attributes :id, :username
end
