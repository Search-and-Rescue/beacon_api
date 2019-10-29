FactoryBot.define do
  factory :search_and_rescue do
    team_name { Faker::Company.name }
    county { "MyString" }
    contact { "Sherrif's Office" }
    contact_number { Faker::PhoneNumber.phone_number }
    city { "Denver" }
    state { "CO" }
  end
end
