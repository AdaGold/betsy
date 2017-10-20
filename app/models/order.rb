class Order < ApplicationRecord
  belongs_to :billing_datum, optional: true
  has_many :order_products
  belongs_to :user, optional: true
  validates :session_id, presence: true
  validates :order_status, presence: true



end
