class Order < ApplicationRecord
  belongs_to :billing_data
  has_many :entries
  belongs_to :user
  validates :session_id, presence: true
  validates :order_status, presence: true



end
