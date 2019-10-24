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

  trip_1 = Trip.create!(
    name: "Rocky Mountain National Park Backpacking Trip",
    starting_point: "Coyote Trail Head",
    ending_point: "Coyote Trail Head",
    start_date: "May 1, 2020",
    start_time: "0800",
    end_date: "May 3, 2020",
    end_time: "2200",
    notification_date: "May 4, 2020",
    notification_time: "1500",
    traveling_companions: 0,
    user_id: user.id
  )

  user = User.create!(
  name: "Bear Grylls",
  email: "bearg@gmail.com",
  address: "335 Cave St",
  city: "Rocky Mountain",
  state: "CO",
  zip: 80220,
  experience_level: 2
)

  trip_2 = Trip.create!(
    name: "Indian Peaks Backpacking Trip",
    starting_point: "Buffalo Trail Head",
    ending_point: "Wolf Trail Head",
    start_date: "June 1, 2020",
    start_time: "0800",
    end_date: "June 3, 2020",
    end_time: "2200",
    notification_date: "June 4, 2020",
    notification_time: "1500",
    traveling_companions: 0,
    user_id: user.id
  )

  vehicle_1 = Vehicle.create!(
    make: "Dodge",
    model: "Ram",
    year: 2010,
    color: "silver",
    license_plate: "CYE 554",
    user_id: 1
  )

  vehicle_2 = Vehicle.create!(
    make: "Subaru",
    model: "Impreza",
    year: 2018,
    color: "green",
    license_plate: "YEY 594",
    user_id: 1
  )
end
