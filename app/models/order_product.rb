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

  def pending?
    order = self.order
    # binding.pry
    if order.order_status == "pending"
      return true
    else
      return false
    end
  end

  def paid?
    order = self.order
    if order.order_status == "paid"
      return true
    else
      return false
    end
  end

  def canceled?
    order = self.order
    if order.order_status == "canceled"
      return true
    else
      return false
    end
  end

  def shipped?
    order = self.order
    if order.order_status == "shipped"
      return true
    else
      return false
    end
  end

  def subtotal
    return (self.quantity) * (self.product.price)
  end

  def items_shipped?
    order = self.order
    entry_items = []
    if order
      order.items.each do |item|
        entry_items << item if item.product_id == product.id
      end
      if entry_items
        entry_items.each do |item|
          return true if item.shipping_status #if item has been shipped, return true
        end
      end
      return false
    end
  end



end
