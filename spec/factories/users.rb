FactoryBot.define do
  factory :user do
    name { "Scruffy McAnderson" }
    address { "MyString" }
    city { "MyString" }
    state { "CO" }
    zip { 80904 }
    phone { "MyString" }
    sequence(:email) { |n| "user-#{n}@example.com" }
    password_digest { "MyString" }
    allergies { "MyString" }
    experience_level { 1 }
    age { 1 }
    weight { 1 }
    hair_color { "MyString" }
    skin_color { "MyString" }
    gender { "MyString" }
    cosar_card { false }
  end
end
