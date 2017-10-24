class OrderProduct < ApplicationRecord
  belongs_to :order
  belongs_to :product
  validates :quantity, presence: true
  validates :quantity, numericality: { only_integer: true }
  validates :quantity, numericality: { greater_than: 0 }
  validate :items_available?

  def items_available?
    product = self.product
    quantity = self.quantity
    if product.num_available >= quantity
      return true
    else
      self.errors[:quantity] << "is invalid. There are currently only #{product.num_available} of #{product.name}. Please update your order."
    end
    return false
  end

end
