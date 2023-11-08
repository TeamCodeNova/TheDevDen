class ProductImage < ApplicationRecord
  # Association with the Product model
  belongs_to :product

  has_one_attached :image

end
