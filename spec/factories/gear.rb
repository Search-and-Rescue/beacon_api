FactoryBot.define do
  factory :gear do
    item_name { Faker::Commerce.product_name }
    user
  end
end
