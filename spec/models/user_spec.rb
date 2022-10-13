# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  context 'presence validations' do
    it { should validate_presence_of :username }
    it { should validate_presence_of :password }
    it { should validate_length_of :password }
    it { should validate_uniqueness_of :username }
    it { should have_secure_password }
  end
end
