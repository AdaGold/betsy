class Order < ApplicationRecord
  belongs_to :billing_datum, optional: true
  has_many :order_products
  belongs_to :user, optional: true
  validates :session_id, presence: true
  validates :order_status, presence: true
  validate :has_billing_datum?
  validate :has_valid_order_status?
  validate :has_valid_order_products?

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

  def has_valid_order_products?
    if self.order_status = "paid"
      invalid_entries = []
      order_products = self.order_products
      order_products.each do |entry|
        invalid_entries << entry if !(entry.valid?)
      end
      if invalid_entries.first != nil
        self.errors[:entries] << "are invalid."
        invalid_entries.each {|entry| self.errors[:entries] << entries.errors}
      end
    end
  end

  private
end
