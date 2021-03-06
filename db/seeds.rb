# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# 'Real' Data
user_1 = User.create(
  name: "Bear Grylls",
  address: "14153 E Montana St",
  city: "Denver",
  state: "CO",
  zip: 80209,
  phone: Faker::PhoneNumber.unique.cell_phone,
  email: "bear_grylls@gmail.com",
  password_digest: Faker::Alphanumeric.unique.alphanumeric(number: 30),
  allergies: "Avocado",
  experience_level: 2,
  birth_date: Faker::Date.between(from: 60.years.ago, to: 18.years.ago),
  weight: 165,
  height: "5ft 11in",
  hair_color: "Brown",
  skin_color: Faker::Color.color_name,
  gender: Faker::Color.color_name,
  cosar_card: Faker::Boolean.boolean
)
EmergencyContact.create(
  name: "Tyler Bierwirth",
  phone: Faker::PhoneNumber.unique.cell_phone,
  email: "tylerbierwirth@gmail.com",
  user_id: user_1.id
)
vehicle = Vehicle.create(
  make: Faker::Vehicle.make,
  model: Faker::Vehicle.model,
  year: Faker::Vehicle.year,
  color: Faker::Vehicle.color,
  state: Faker::Address.state_abbr,
  license_plate: Faker::Vehicle.license_plate,
  user_id: user_1.id
)
real_trip = Trip.create(
  name: "4 Pass Loop",
  activity_type: "Hiking",
  starting_point: "Maroon Snowmass Trailhead",
  ending_point: "Maroon Snowmass Trailhead",
  start_date: Date.current - 1.day,
  start_time: Time.current - 12.hours,
  end_date: Date.current,
  end_time: Time.current - 6.hours,
  notification_date: Date.current,
  notification_time: Time.current - 2.hours,
  traveling_companions: 0,
  user_id: user_1.id,
  vehicle_id: vehicle.id,
  active: true
)
10.times do
  item = Gear.create(
    item_name: Faker::Commerce.product_name,
    description: Faker::ChuckNorris.fact,
    user_id: user_1.id
  )
  TripGear.create(
    trip_id: real_trip.id,
    gear_id: item.id,
    comments: Faker::ChuckNorris.fact
  )
end

# 'Fake' Data
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
    birth_date: Faker::Date.between(from: 60.years.ago, to: 18.years.ago),
    weight: rand(90..300),
    height: Faker::Measurement.height,
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
  Vehicle.create(
    make: Faker::Vehicle.make,
    model: Faker::Vehicle.model,
    year: Faker::Vehicle.year,
    color: Faker::Vehicle.color,
    state: Faker::Address.state_abbr,
    license_plate: Faker::Vehicle.license_plate,
    user_id: user.id
  )
end

50.times do
  name = Faker::Company.name
  start_date = Faker::Date.between(from: 6.days.ago, to: Date.today)
  end_date = Faker::Date.between(from: Date.today, to: 6.days.from_now)
  trip = Trip.create(
    name: name,
    activity_type: Faker::Job.key_skill,
    starting_point: name,
    ending_point: Faker::Company.name,
    start_date: start_date,
    start_time: start_date,
    end_date: end_date,
    end_time: end_date,
    notification_date: end_date + 1.day,
    notification_time: end_date + 1.hour,
    traveling_companions: rand(1..2),
    user_id: User.find(User.pluck(:id).sample).id,
    active: false
  )
  user = User.find(trip.user_id)
  contact = user.emergency_contacts.sample
  TripContact.create(emergency_contact_id: contact.id, trip_id: trip.id)
end

100.times do
  item = Gear.create(
    item_name: Faker::Commerce.product_name,
    description: Faker::ChuckNorris.fact,
    user_id: User.find(User.pluck(:id).sample).id
  )
  TripGear.create(
    trip_id: Trip.find(Trip.pluck(:id).sample).id,
    gear_id: item.id,
    comments: Faker::ChuckNorris.fact
  )
end

# Users that have not "checked in"
2.times do
  name = Faker::Company.name
  Trip.create(
    name: name,
    activity_type: Faker::Job.key_skill,
    starting_point: name,
    ending_point: Faker::Company.name,
    start_date: Date.current - 1.day,
    start_time: Time.current - 12.hours,
    end_date: Date.current,
    end_time: Time.current - 6.hours,
    notification_date: Date.current,
    notification_time: Time.current - 2.hours,
    traveling_companions: rand(1..2),
    user_id: User.find(User.pluck(:id).sample).id,
    active: true
  )
end
