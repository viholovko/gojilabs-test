FactoryBot.define do
  factory :subject do
    name { FFaker::Education.major }
  end
end 