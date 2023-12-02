class Order < ApplicationRecord
  belongs_to :user
  has_many :order_items
  has_many :products, through: :order_items

  def calculate_total(cart_items)
    subtotal = cart_items.sum { |item| item.product.product_price * item.quantity }
    tax_rate = 0.05 # Canadian tax rate (5%)
    self.tax = subtotal * tax_rate
    self.total = subtotal + self.tax
  end
end
