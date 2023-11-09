require 'faker'

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

# Clear existing data
Category.delete_all
Product.delete_all

# Create 4 categories using Faker
4.times do
  Category.create(category_name: Faker::Lorem.word)
end

# Create 100 products using Faker
100.times do
  Product.create(
    product_name: Faker::Commerce.product_name,
    product_description: Faker::Lorem.sentence,
    product_price: Faker::Commerce.price(range: 10.0..100.0),
    category_id: Category.pluck(:id).sample
  )
end

puts "Seeded #{Category.count} categories."
puts "Seeded #{Product.count} products."
