# db/seeds.rb

# Categories
Category.create(category_name: 'Python')
Category.create(category_name: 'Ruby')
# Add more categories as needed

# Admin User
User.create(user_name: 'admin', password: 'password123', is_admin: true)

# Products
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
# Add more products as needed
