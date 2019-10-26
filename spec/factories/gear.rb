FactoryBot.define do
  factory :gear do
    item_name { Faker::Commerce.product_name }
    description { Faker::ChuckNorris.fact }
    user
  end
end
