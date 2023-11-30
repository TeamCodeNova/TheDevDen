require 'faker'

# Clear existing data
User.delete_all
Province.delete_all

# Create provinces in Canada
canadian_provinces = [
  'Alberta', 'British Columbia', 'Manitoba', 'New Brunswick', 'Newfoundland and Labrador',
  'Nova Scotia', 'Ontario', 'Prince Edward Island', 'Quebec', 'Saskatchewan', 'Northwest Territories',
  'Nunavut', 'Yukon'
]

canadian_provinces.each do |province_name|
  Province.create(province_name: province_name)
end

# Create an admin user with a province
admin_province = Province.first

User.create!(
  name: 'admin',
  email: 'admin@example.com',
  password: 'admin123',
  address: '123 Fake St',
  province: Province.second,
  admin: true,

)

# Create two other fake users with provinces
User.create!(
  name: 'test1',
  email: 'test1@example.com',
  password: 'password1',
  address: '456 Fake Ave',
  province: Province.second
)

User.create!(
  name: 'test2',
  email: 'test2@example.com',
  password: 'password2',
  address: '789 Fake Blvd',
  province: Province.third
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
puts "Seeded #{Province.count} provinces."
