# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create!(name: 'michael', email: 'michael@example.com', password: 'autos1')
User.create!(name: 'peter', email: 'peter@example.com', password: 'autos2')
User.create!(name: 'jenny', email: 'jenny@example.com', password: 'autos3')
User.create!(name: 'sophie', email: 'sophie@example.com', password: 'autos4')
User.create!(name: 'kane', email: 'kane@example.com', password: 'autos5')

users = User.order(:created_at).take(5)
40.times do
  content = Faker::Lorem.sentence(5)
  users.each { |user| user.posts.create!(content: content) }
end