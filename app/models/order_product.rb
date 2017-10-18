class OrderProduct < ApplicationRecord
  belongs_to :order
  belongs_to :product
  validates :quantity, presence: true
  validates :quantity, numericality: { only_integer: true }
  validates :quantity, numericality: { greater_than: 0 }


end
