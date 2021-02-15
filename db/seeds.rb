# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
require 'faker'
User.destroy_all
Boat.destroy_all
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
array = [1, 2, 3]
10.times do
  user = User.create(email: Faker::Internet.email, password: Faker::Internet.password)
  nb = array.sample
  nb.times do
    Boat.create(name: Faker::Name.first_name, price: rand(50..200), localisation: Faker::Address.city, user_id: user.id, category: "Voilier", capacity: rand(2..10))
  end
end


