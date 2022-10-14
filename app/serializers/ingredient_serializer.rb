# frozen_string_literal: true

class IngredientSerializer < ActiveModel::Serializer
  belongs_to :recipe
  attributes :id, :name, :metric
  attribute :imperial, if: :imperial_scope?
  attribute :metric, if: :metric_scope?

  def imperial_scope?
    object.has_attribute?(:imperial)
  end

  def metric_scope?
    object.has_attribute?(:metric)
  end
end
