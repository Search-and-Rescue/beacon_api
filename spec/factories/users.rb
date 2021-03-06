FactoryBot.define do
  factory :user do
    name { Faker::Name.unique.name }
    address { Faker::Address.unique.street_address }
    city { Faker::Address.city }
    state { Faker::Address.state_abbr }
    zip { Faker::Number.number(digits: 5) }
    phone { Faker::PhoneNumber.unique.cell_phone }
    email { Faker::Internet.unique.email(name: name) }
    password_digest { Faker::Alphanumeric.unique.alphanumeric(number: 30) }
    allergies { Faker::Food.fruits }
    experience_level { rand(0...2) }
    birth_date { Faker::Date.between(from: 60.years.ago, to: 18.years.ago) }
    weight { rand(100..300) }
    hair_color { Faker::Color.color_name }
    skin_color { Faker::Color.color_name }
    gender { Faker::Color.color_name }
    cosar_card { Faker::Boolean.boolean }
  end
end
