FactoryBot.define do
  factory :section do
    association :teacher
    association :subject
    association :classroom
    start_time { Time.zone.parse("08:00") }
    end_time { Time.zone.parse("08:50") }
    days { "MWF" }
  end
end