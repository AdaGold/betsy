class Orderitem < ApplicationRecord
  belongs_to :product
  belongs_to :order

  validates :quantity, presence: true
  validates :quantity, numericality: { greater_than: 0 }
  validates :quantity, numericality: { only_integer: true }

end
