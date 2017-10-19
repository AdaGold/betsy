class Order < ApplicationRecord
  belongs_to :billing_data
  has_many :entries
  belongs_to :user, optional: true
  validates :session_id, presence: true
  validates :order_status, presence: true



end
