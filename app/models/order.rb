class Order < ApplicationRecord
  belongs_to :billing_datum, optional: true
  has_many :order_products
  has_many :items
  belongs_to :user, optional: true
  validates :session_id, presence: true
  validates :order_status, presence: true
  validate :has_billing_datum?
  validate :has_valid_order_status?
  # validate :has_valid_order_products?


  def sub_total
    entries = self.order_products
    sub_total = 0
    entries.each do |entry|
      unit_price = entry.product.price
      entry_cost = unit_price * entry.quantity
      sub_total += entry_cost
    end
    return sub_total
  end

  def tax_amount
    sub_total = self.sub_total
    tax = sub_total * 0.0887
    return tax
  end

  def taxed_total
    tax = self.tax_amount
    sub_total = self.sub_total
    return sub_total + tax
  end

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
    return entries_by_product
  end

  def check_for_duplicates(input_product_id)
    entries = self.entries_by_product
    if entries[input_product_id]
      return entries[input_product_id][0]
    else
      return false
    end
  end

  #gets called if check_for_duplicates returns true
  def combine_entries(entry_id)
    entries = self.entries_by_product
    product = entry.product
  end

  def has_valid_order_products
    entries = self.order_products
    entries.each { |entry| return false if !(entry.valid?)}
    return true
  end

end
