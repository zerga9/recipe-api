# frozen_string_literal: true

require 'rails_helper'

RSpec.describe IngredientSerializer do
  subject { IngredientSerializer.new(ingredient) }
  let(:ingredient) { create(:ingredient) }

  it 'includes the expected attributes' do
    expect(subject.attributes.keys)
      .to contain_exactly(
        :id,
        :name,
        :metric,
        :imperial
      )
  end
end
