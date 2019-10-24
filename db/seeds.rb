# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
20.times do
  name = Faker::Name.unique.name
  user = User.create(
    name: name,
    address: Faker::Address.unique.street_address,
    city: Faker::Address.city,
    state: Faker::Address.state_abbr,
    zip: Faker::Number.number(digits: 5),
    phone: Faker::PhoneNumber.unique.cell_phone,
    email: Faker::Internet.unique.email(name: name),
    password_digest: Faker::Alphanumeric.unique.alphanumeric(number: 30),
    allergies: Faker::Food.fruits,
    experience_level: Faker::Number.between(from: 0, to: 2),
    age: rand(15..100),
    weight: rand(90..300),
    hair_color: Faker::Color.color_name,
    skin_color: Faker::Color.color_name,
    gender: Faker::Color.color_name,
    cosar_card: Faker::Boolean.boolean
  )
  contact_name = Faker::Name.unique.name
  EmergencyContact.create(
    name: contact_name,
    phone: Faker::PhoneNumber.unique.cell_phone,
    email: Faker::Internet.unique.email(name: contact_name),
    user_id: user.id
  )
end

50.times do
  name = Faker::Company.name
  start_date = Faker::Date.between(from: 6.days.ago, to: Date.today)
  end_date = Faker::Date.between(from: Date.today, to: 6.days.from_now)
  Trip.create(
    name: name,
    starting_point: name,
    ending_point: Faker::Company.name,
    start_date: start_date,
    start_time: start_date,
    end_date: end_date,
    end_time: end_date,
    notification_date: end_date + 1,
    notification_time: end_date + 1 ,
    traveling_companions: rand(1..2),
    user_id: User.find(User.pluck(:id).sample).id
  )

end
