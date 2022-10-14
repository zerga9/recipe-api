# frozen_string_literal: true

FactoryBot.define do
  factory :recipe do
    title { 'MyTitle' }
    description { 'MyDescription' }
    process { 'MyProcess' }
    association :user, strategy: :build
  end
end
