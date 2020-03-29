FactoryBot.define do
  factory :event do
    name { "1 Hour Clean-Up" }
    description { "Quick Clean Up" }
    location_description { "Meet at the flag pole." }
    event_date { "12/12/2050".to_date }
    start_time { "12/12/2050 10AM".to_time.in_time_zone }
    end_time { "12/12/2050 11AM".to_time.in_time_zone }
  end
end