FactoryBot.define do
  factory :neighborhood do
    name { "Basic Neighborhood" }
    description { "The Most Basic Neighborhood" }
    message { "This is a temporary message." }
    lat { 1.0 }
    lng { 1.0 }
    zoom { 10 }
    published { true }

    factory :neighborhood_with_block do
      after(:create) do |neighborhood|
        create(:block, neighborhood: neighborhood)
      end
    end

  end
end
