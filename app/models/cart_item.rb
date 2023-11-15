class CartItem < ApplicationRecord
  belongs_to :user
  belongs_to :product, optional: true  # Allow the product association to be optional

  validates :quantity, numericality: { greater_than: 0 }
end
