# db/seeds.rb

# Clear the users table before seeding to prevent duplication if you re-seed
User.delete_all

# Create an admin user
User.create!(
  name: 'admin',
  email: 'admin@example.com',
  password: 'admin123',
  address: '123 Fake St',
  # Set the admin flag to true if you have this attribute; remove if you don't
  admin: true
)

# Create two other fake users
User.create!(
  name: 'test1',
  email: 'test1@example.com',
  password: 'password1',
  address: '456 Fake Ave'
)

User.create!(
  name: 'test2',
  email: 'test2@example.com',
  password: 'password2',
  address: '789 Fake Blvd'
)

puts "Seeded #{User.count} users."
