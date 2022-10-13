# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    sequence(:username) { |s| "UserName#{s}" }
    password { 'MyPassword' }
  end
end
