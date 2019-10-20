FactoryBot.define do
  factory :user do
    name { "MyString" }
    address { "MyString" }
    city { "MyString" }
    state { "MyString" }
    zip { 1 }
    phone { "MyString" }
    email { "MyString" }
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
