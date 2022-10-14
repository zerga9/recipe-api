# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RecipeSerializer do
  subject { RecipeSerializer.new(recipe) }
  let(:recipe) { create(:recipe) }

  it 'includes the expected attributes' do
    expect(subject.attributes.keys)
      .to contain_exactly(
        :id,
        :title,
        :description,
        :process
      )
  end
end
