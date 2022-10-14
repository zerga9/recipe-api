# frozen_string_literal

FactoryBot.define do
  factory :rating do
    association :recipe, strategy: :build
    association :user, strategy: :build
    rating { 1 }
  end
end
