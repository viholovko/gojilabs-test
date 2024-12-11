FactoryBot.define do
  factory :enrollment do
    association :student
    association :section
  end
end 