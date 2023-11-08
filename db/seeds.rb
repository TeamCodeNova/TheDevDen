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

# Categories
Category.delete_all
Category.create(category_name: 'Python')
Category.create(category_name: 'Ruby')
# Add more categories as needed

# Products
Product.delete_all
Product.create(
  product_name: 'Web Scraper',
  product_description: 'A Web Scraper',
  product_price: 19.99,
  category_id: 1
)
Product.create(
  product_name: 'Final Project',
  product_description: 'Ruby',
  product_price: 29.99,
  category_id: 2
)
