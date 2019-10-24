FactoryBot.define do
  factory :user do
    name { Faker::Name.unique.name }
    address { Faker::Address.unique.street_address }
    city { Faker::Address.unique.city }
    state { Faker::Address.unique.state_abbr }
    zip { Faker::Number.unique.number(digits: 5) }
    phone { Faker::PhoneNumber.unique.cell_phone }
    email { Faker::Internet.unique.email(name: name) }
    password_digest { Faker::Alphanumeric.unique.alphanumeric(number: 30) }
    allergies { Faker::Food.unique.fruits }
    experience_level { rand(0...2) }
    age { rand(15..100) }
    weight { rand(100..300) }
    hair_color { Faker::Color.color_name }
    skin_color { Faker::Color.color_name }
    gender { Faker::Color.color_name }
    cosar_card { Faker::Boolean.boolean }
  end
end
