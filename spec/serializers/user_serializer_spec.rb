# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserSerializer do
  subject {  UserSerializer.new(user) }
  let(:user) { create(:user) }

  it 'includes the expected attributes' do
    expect(subject.attributes.keys)
      .to contain_exactly(
        :id,
        :username
      )
  end
end
