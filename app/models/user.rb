class User < ApplicationRecord
  has_many :products
  has_many :orders
  has_many :reviews

  belongs_to :billing_datum, optional: true

  validates :username, presence: true
  validates :username, uniqueness: true
  validates :email, presence: true

  def merchant_entries
    products = self.products
    merchant_entries = []
    products.each do |product|
      entries = OrderProduct.where(product_id: product.id)
      entries.each { |entry| merchant_entries << entry if !(entry.pending?)}
    end
    return merchant_entries if merchant_entries.first != nil
    return false
  end

  def merchant_pending_entries
    entries = merchant_entries
    pending_entries = []
    entries.each { |entry| pending_entries << entry if entry.pending?}
  end




  def find_pending_order #synonymous to cart
    pending_orders = []
    self.orders.each do |order|
      pending_orders << order if order.order_status == "pending"
    end
    if pending_orders.length > 1
      # some logic about combining the contents of the orders
    elsif pending_orders.length == 1
      return pending_orders.first
    else
      return false
    end
  end

  def has_products
    has_products = []
    User.all.each do |user|
      if user.products.length > 0
        has_products.push(user)
      end
    end
    return has_products
  end

  def show_available
    Product.where(visibility: true)
  end
end
