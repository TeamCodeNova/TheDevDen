class Product < ApplicationRecord
  belongs_to :category
  has_many :carts
  has_many :users, through: :carts
  has_many :product_images, dependent: :destroy
  has_one_attached :image
  accepts_nested_attributes_for :product_images, allow_destroy: true

  validates :product_name, presence: true
  validates :product_description, presence: true
  validates :product_price, presence: true, numericality: { greater_than: 0 }
end
