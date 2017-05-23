User.create!(
  name: 'Admin User',
  password: '123qwe',
  email: 'admin@user.com',
  role: 'admin',
  confirmed_at: DateTime.now  # skip confirmation
)
  
5.times do
  fake_first_name = Faker::Name.first_name
  fake_last_name = Faker::Name.last_name
  User.create!(
    name: fake_first_name + " " + fake_last_name,
    password: 'password',
    email: Faker::Internet.email(fake_first_name + "." + fake_last_name),
    confirmed_at: DateTime.now  # skip confirmation
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
