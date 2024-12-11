FactoryBot.define do
  factory :student do
    name { "Jane Doe" }
    email { FFaker::Internet.unique.email }

    trait :with_invalid_email do
      email { "invalid_email" }
    end

    trait :without_name do
      name { nil }
    end
  end
end 