class Item < ApplicationRecord
  belongs_to :product
  belongs_to :order, optional: true
  validates :shipping_status, presence: true
  validates :purchase_status, presence: true


end
