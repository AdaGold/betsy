class Order < ApplicationRecord
  belongs_to :billing_datum, optional: true
  has_many :order_products
  belongs_to :user, optional: true
  validates :session_id, presence: true
  validates :order_status, presence: true
  validate :has_billing_datum?
  validate :has_valid_order_status?
  # validate :has_valid_order_products?

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

  def has_invalid_entries?
      invalid_entries = []
      order_products = self.order_products
      order_products.each do |entry|
        invalid_entries << entry if !(entry.valid?)
      end
      if invalid_entries.first != nil
        self.errors[:entries] << "are invalid."
        invalid_entries.each {|entry| self.errors[:entries] << entries.errors}
        return true #is NOT a valid order
      else
        return false #is a valid order
      end
  end

  def entries_by_product
    entries_by_product = self.order_products.group_by {|entry| entry.product_id}
  end

  def check_for_duplicates(input_product_id)
    entries = self.entries_by_product
    entries_by_product[input_product_id].length == 1 ? (return entries_by_product[input_product_id][0]) : return false
  end

  #gets called if check_for_duplicates returns true
  def combine_entries(entry_id)
    entries = self.entries_by_product
    product = entry.product

end
