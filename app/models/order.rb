class Order < ApplicationRecord
  belongs_to :user
  has_many :order_items
  has_many :products, through: :order_items

  validates :total, numericality: { greater_than_or_equal_to: 0 }
  validates :tax, numericality: { greater_than_or_equal_to: 0 }
  validates :user_id, presence: true

  def calculate_total(cart_items)
    tax =  0.05
    subtotal = cart_items.sum { |item| item.product.product_price * item.quantity }
    tax_rate = tax
    self.tax = subtotal * tax_rate
    self.total = subtotal + self.tax
  end
end
