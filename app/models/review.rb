class Review < ApplicationRecord
  belongs_to :product

    validates :rating, presence: true
    validates :rating, numericality: { only_integer: true }
    validates :rating, numericality: { greater_than_or_equal_to: 1 }
    validates :rating, numericality: { less_than_or_equal_to: 5 }
end
