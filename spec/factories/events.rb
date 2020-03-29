FactoryBot.define do
  factory :event do
    name { "1 Hour Clean-Up" }
    description { "Quick Clean Up" }
    location_description { "Meet at the flag pole." }
    event_date { "12/12/2050".to_date }
    start_time { Time.zone.local(2050, 12, 12, 10, 00)}
    end_time { Time.zone.local(2050, 12, 12, 11, 00) }
  end
end