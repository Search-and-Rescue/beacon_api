FactoryBot.define do
  factory :trip_gear do
    trip
    gear
    comments { Faker::ChuckNorris.fact }
  end
end
