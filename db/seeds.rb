# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create!(
  name: 'Admin User',
  password: '123qwe',
  email: 'admin@user.com',
  role: 'admin')
  
5.times do
  fake_first_name = Faker::Name.first_name
  fake_last_name = Faker::Name.last_name
  User.create!(
    name: fake_first_name + " " + fake_last_name,
    password: 'password',
    email: Faker::Internet.email(fake_first_name + "." + fake_last_name),
    confirmed_at: DateTime.now
    # skip confirmation
  )
end

5.times do
  fake_title = Faker::Lorem.word
  Wiki.create!(
    title: fake_title,
    body: fake_title + ": " + Faker::Lorem.paragraph,
    user: User.all.sample
  )
 end

puts "Seed finished"
puts "#{User.count} fake users created"
puts "#{Wiki.count} fake wikis created"