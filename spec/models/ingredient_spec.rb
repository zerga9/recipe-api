# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Ingredient, type: :model do
  context 'presence validations' do
    it { should validate_presence_of :name }
  end

  context 'associations' do
    it { should belong_to :recipe }
  end
end
