FactoryBot.define do
  factory :classroom do
    name { "Room #{FFaker::Address.building_number}" }
  end
end 