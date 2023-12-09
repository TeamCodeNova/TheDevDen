class User < ApplicationRecord
  # Virtual attribute for authenticating by remember token
  attr_accessor :remember_token
  belongs_to :province, optional: true

  has_secure_password

  validates :email, presence: true, uniqueness: { case_sensitive: false }

  validates :name, presence: true
  validates :address, presence: true
  validates :province, presence: true

  has_many :cart_items
  has_many :orders

  # Generates a new remember token and saves its digest to the database
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  # Deletes the user's remember digest, effectively forgetting the user
  def forget
    update_attribute(:remember_digest, nil)
  end

  # Returns true if the given token matches the digest
  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  # Returns a new random token
  def self.new_token
    SecureRandom.urlsafe_base64
  end

  # Returns the hash digest of a token
  def self.digest(token)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(token, cost: cost)
  end

  def admin?
    self.admin
  end
end
