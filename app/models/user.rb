# app/models/user.rb
class User < ApplicationRecord
  has_secure_password # This enables secure password management

  # Define other attributes as needed
  validates :email, presence: true, uniqueness: true
  # Add other validations as needed
end
