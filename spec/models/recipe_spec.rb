# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Recipe, type: :model do
  context 'presence validations' do
    it { should validate_presence_of :title }
    it { should validate_presence_of :description }
    it { should validate_presence_of :process }
  end

  context 'associations' do
    it { should belong_to :user }
  end
end
