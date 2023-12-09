class Province < ApplicationRecord
    has_many :users

    validates :province_name, presence: true
  end
