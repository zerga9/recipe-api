FactoryBot.define do
  factory :ingredient do
    association :recipe, strategy: :build
    name { 'MyIngredient' }
    metric do
      {
        amount: 100,
        unit: 'gram'
      }
    end
    imperial do
      {
        amount: 3.5,
        unit: 'ounce'
      }
    end
  end
end
