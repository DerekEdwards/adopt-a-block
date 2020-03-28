FactoryBot.define do
  factory :user do
    name { "George P Burdell" }
    email { "gpburdell@example.com" }
    admin { false }
    subscribed_to_reminders { true }
    subscribed_to_neighborhood_updates { true }
    password { 'abcde12345' }
    password_confirmation { 'abcde12345' }

    factory :user2 do
      name { "User 2" }
      email { "User2@example.com" }
    end

    factory :admin do
      name { "Admin" }
      email { "Admin@example.com" }
      admin { true }
    end

  end
end