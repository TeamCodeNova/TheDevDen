class Account < ApplicationRecord
  # Association with User
  belongs_to :user
end
