class ProductImage < ApplicationRecord
  # Association with the Product model
  belongs_to :product

  # Assuming you're using something like CarrierWave, Paperclip, or Active Storage for image uploads:
  has_one_attached :image

  # Validations and other custom logic (if necessary)
  # For example, validate presence of image, file type, etc.
  # validates :image, presence: true
  # ... more custom logic
end
