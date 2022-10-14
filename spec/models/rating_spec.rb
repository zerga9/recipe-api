# frozen_string_literal: true

RSpec.describe Rating, type: :model do
  let(:subject) { build(:rating) }

  context 'validations' do
    it { should validate_presence_of :rating }
    it { should validate_inclusion_of(:rating).in_range(0..5) }
  end

  context 'associations' do
    it { should belong_to :user }
    it { should belong_to :recipe }
  end
end
