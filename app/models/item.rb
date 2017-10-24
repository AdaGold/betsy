class Item < ApplicationRecord
  belongs_to :product
  belongs_to :order, optional: true
  validates :shipping_status, inclusion: {in: [true,false]}
  validates :purchase_status, inclusion: {in: [true,false]}

  def purchase(input_order_id)
    if self.purchase_status != false
      self.errors[:order_id] << "does not match item.  This items is tied to order #{self.order_id}, you were trying to ship it for #{input_order_id}."
      return false
    else
      self.order_id = input_order_id
      self.purchase_status = true
      return true
    end
  end

  def ship(input_order_id)
    if input_order_id != self.order_id
      self.errors[:order_id] << "does not match item.  This items is tied to order #{self.order_id}, you were trying to ship it for #{input_order_id}."
      return false
    elsif self.purchase_status != true
      self.errors[:purchase_status] << "Cannot ship an unpurchased item.  Please make sure item is purchased before shipping."
      return false
    else
      self.purchase_status = true
      return true
    end
  end
end
