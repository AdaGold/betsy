class Order < ApplicationRecord
  belongs_to :billing_datum, optional: true
  has_many :order_products
  belongs_to :user, optional: true
  validates :session_id, presence: true
  validates :order_status, presence: true
  validate :has_billing_datum?
  validate :has_valid_order_status?

  def has_billing_datum?
    if self.order_status != "pending"
      self.errors[:billing_datum_id] << "is missing.  Please entire valid billing information." if !(self.billing_datum_id)
    end
  end

  def has_valid_order_status?
    valid_statuses = ["pending", "paid", "shipped", "canceled"]
    if !(valid_statuses.include? self.order_status)
      self.errors[:order_status] << "is invalid."
    end
  end

private
end
