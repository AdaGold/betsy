class Review < ApplicationRecord
  belongs_to :product

    validates :rating, presence: true
    validates :rating, numericality: { only_integer: true }
    validates :rating, numericality: { greater_than_or_equal_to: 1 }
    validates :rating, numericality: { less_than_or_equal_to: 5 }
    validates :title, presence: true, length: { in: 2..100 }
    validates :review_text, presence: true, length: { in: 2..700 }
    # TODO: Do we want to restrict users to 1 review and allow them to update it
end
