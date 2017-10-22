class User < ApplicationRecord
  has_many :products
  has_many :orders
  has_many :reviews

  belongs_to :billing_datum, optional: true

  validates :username, presence: true
  validates :username, uniqueness: true
  validates :email, presence: true




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



end
